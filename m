Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5423A606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DVldhuuX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPSnT-0007VD-85; Fri, 06 Nov 2026 17:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xPSnP-0007V4-Hv
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:52:31 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xPSnN-0004cZ-EV
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:52:31 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2e985106c0cso8806115ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794005547; x=1794610347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jO79Cr/RetwdN8bJjslSOy0b0KewYPFh7HRkZcjgfjk=;
 b=DVldhuuXQ/Rpm8vj1bY72iNNG9EU5FPG9fBH0lubZaHjggUyyblibs7Fj4MjH/6GHn
 IKRQ3gNgZcj5lg6TXWLxSf3CxDQIUa7aYssoMi+nj8tYHgJrJPqbqLTMVjfRTZz4ZcaT
 A5046X32ihowsGhULGy8mwCGC2ksmq9snn9aCJyzKr6E5997KySYn+rVldwI4RZm1ysi
 +uqI9k5awq0GBYm1ixA7iQIn0+jlhdzHBG9Rpq7/VEJjq0nPWeGHygzLywV/+skyXFi+
 kVVw1feTSB2/rHXi/x+Uxbmej7gtEu1KhdU83VkBGwja051NkoBVD7UO1oDLamOkkOkI
 kG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794005547; x=1794610347;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jO79Cr/RetwdN8bJjslSOy0b0KewYPFh7HRkZcjgfjk=;
 b=weEbEC6E3Y6OgX0WZ9N2MxAWwqGwlSy5n85ESf9nkUaIeAPxkHArttMSdyjmNcIfJD
 StzWbMFgIaeyWvJMRzF3sidUHTIuq+H0Mfz4cVcvSvg27xBgcWfCsrxeokja9v9+kVX2
 caCLMz+zGJG/05eDZrDakpoe3iRXC8PVhIFOzA7t0LgkH0dCsZFzdQbiNTFSFjJxUS91
 Sn9iL01ItslkRT2ktRlVQ7L838SD16r+lXeBBYm/Wku3EINed2+DT3EIDHdl54+mJx+m
 IUS8PnSXflMDJc/1DslIBLvq6+/tbu94YqndjEQGnTr07R+D6qfhufNzrilnyMgBZvjA
 /a1g==
X-Forwarded-Encrypted: i=1;
 AL+hErECjxMnFWb9Cb0CltyMLJczT9D3sAE2EbNeLme6ry51PtZC4w1GxWN40UhCIol+sZtz+RZREUEXsPAF@nongnu.org
X-Gm-Message-State: APuU4Z++YDLKEAdNJUjKnHfW8QPZK1bfMFv3yUPFzA4ohbSrFvvrc2Y9
 jt15E/a7bkpnsMHYiUf7HrcLXYRlkPbfbPL0NCOfScTw9FHzaNiLerL3ULjZz42ENsM=
X-Gm-Gg: AYBFou140eiFw/1lspTwnVCf0Ltl3zadjvAFDHOkwMPyvbP/qX09mKajkT4AHtG6evz
 a5+Gjk5Nm6jAYAhugMAZEbLG/oATrBZTJDSmwkEHp0IpfKUlxkc+ntu5nKSCYvBn4uZ4B4wt6db
 c/236CB3oQ2DVRT7CVv2AsjWIxRpNN1m+3FAUeM1Jyz0x0R5pR/AUO6ENkRITHz/ohnV7/DXljK
 Wd1MJE5P+B2IKqL8K9SnNjqkL1RW61/oZ7pFrXtaGpddeMwtwnwYwGhUh4tlLXgg7TOJOYtb6+P
 1j1S2uWlrs2PCRqcrHPFL4ITdTQgGZggxhL0AUChrMAztZZwCMFLH795G3dnXnFmpV8cqstFjBe
 +osbW6KsaL9nu8W9Ujg7rWs9H/uqv3ourcIVtEStXTi12EUcI0nZrWPQU5VQm7U64Q/7bUJPP8T
 OMClKSp07pAnxrR8Z2STLGpl62WXZGAWVC4wuvjRUifNOx1HXu8X4eW5rdl1jS86AHl5QHfxIO3
 DlMmcV8W+HBsZPE2mcgTnPeeM43Z23F7bF7JkFoN+WVoBGywLHtTrhlCM7x2ua2Z1rCbj5qEPVK
 D4K1zHp5KZ+X9Zn/QS8nDkGlWjqXp5YMa8H+hQlezwKdVZzPzo/d0mhJftQbnGN5TGsIzw==
X-Received: by 2002:a17:902:d54f:b0:2ed:e0a:1138 with SMTP id
 d9443c01a7336-2ed4128773emr46319095ad.4.1794005547466; 
 Fri, 06 Nov 2026 14:52:27 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47da1652sm9024085ad.74.2026.11.06.14.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 14:52:26 -0800 (PST)
Message-ID: <ca43197d-759c-4e95-a6ee-b33b9d043b71@linaro.org>
Date: Fri, 6 Nov 2026 14:52:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] multi-target Final fixes for 11.2
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 11:03, Pierrick Bouvier wrote:
> The following changes since commit 76fdb3373c9a27b3f50ecc9e012cbdeb90af7151:
> 
>    Merge tag 'hppa-715-cpu-nic-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-11-06 07:49:02 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261106
> 
> for you to fetch changes up to 1b879fe489f8894c5b07438f0b10706db916ca4f:
> 
>    multi-target: restrict whpx-accel-*-cpu to matching target (2026-11-06 17:56:13 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH 0/4] hw/misc: move vmlaunchupdate.c to system_ss (=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?=<berrange@redhat.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261106171836.2020151-1- 
> berrange@redhat.com
> - [PATCH v2] multi-target: restrict whpx-accel-*-cpu to matching target (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261106175326.22629-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

