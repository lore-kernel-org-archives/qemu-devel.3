Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41CF606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IXQ3qoFR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTmG7-0002DE-9x; Wed, 18 Nov 2026 15:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTmG0-0002CO-52
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 15:27:53 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTmFy-00054m-4E
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 15:27:51 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2e96502e447so12080025ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795033668; x=1795638468; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h2BvSNqkQhc6pqjJhFZlFetTwttDIB1qQuDIgEzss0I=;
 b=IXQ3qoFR/k33X/X5JoJfgPkXbZBz3u/dWSwNqhQQz9n8gmWapt+GtccNDjPE+GsRLo
 GRF2/7hTsTGuAh8hVMn8C58LNhJMDclNkngXp+p6XL26L1R2JukxKAKxbROCZrHYUMk7
 uNVTn0vhz8NxxuaPkXpkjX8fG/HDLJsly/Jf6IhTZyoibdg5obwCw/NTMgV9Xzh5+LiH
 syA9fnQvCsFPS1hq5v30WOfYGjMDykAPQ/Vr8c5d+EPKAV1SYLPxCvSEHCoDfyartGhf
 3mdS0T+dWvuUewldbaCxbbWmvxrpaxyjtMsm51/JPPLd4DKYE+FwVHCQH5rg7yc+oGGo
 biIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795033668; x=1795638468;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h2BvSNqkQhc6pqjJhFZlFetTwttDIB1qQuDIgEzss0I=;
 b=HNHDeMfGxPHD8IrPv0442zzfeLPbdCG+ErNEuUKP+pXc4atw24s55oGvoyVvEVl+p6
 q1UPu+umw6H6A+GhIufHR74WydimznvAwLUPyLfoxygbDu0eTDLkMJiRy6cJKB5uUUie
 K86CbaMsFQrOKIU4nZG9xdY2JvIseiJHWf1nMWBh5TVrrNvC/WBrC5pTx5O23U8UDJdn
 hRcMK659tLb7jZ1pBDus2rVm4nPSiKbJJ2oJcRvuFdQnyVnH7De4FvfEE6gi7Xs5LYWp
 U+ZCJqzqDTDUhxOHlvf2uhOZCptSiDZuuKdWwwGdRW1/6oe4wtFbKow4CMP7uq0rnN8h
 n6wQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGeuYZr5QuEBWkX9Nec1/hRQNcryva9dfNVJ3c8e4gevW1u813hYsAVOLAeP1PTnsbm/BCQyW5RIGRf@nongnu.org
X-Gm-Message-State: APuU4Z+fa6BPz5jpVfWvnlI/2Tq4YZfMFD83a64aHN6EQInB2PDawrwA
 BpKhQCj/I9SHh5ywMxAt+B7+ho0qpD/loZfFY3Gq9czq9+SUTB+SloKJJ8T5FDh1218=
X-Gm-Gg: AZFdTZdKZS8n2WFbAtqHIxt2/uNEGDp+N/3jQo4VOKBovbnS8S78M3eYS/SpOthJckg
 A7m1CzMWHVpXOuCp3F1crZAQlqNOgamEAigtWb7okmxYGrAekpxJ0WnpQvKg/LuqZWPvSnREq0L
 p5vue1NxQnUD6EX4Nyg71CliFNPp8EtYp4bVHpN7wgaZ8mXjLQ3+DQBXmUnD6UeNfVUP32GOSyy
 BnKge7+r9anM/zbpxKbW2kvymL7YLDRfndKwUGSiKiJ6wbL7T8jo8hjtF6A/TTGvOxLwE1UQQYl
 3xV/x9ZgY72+a3xbCqpftTMeJYl8Hj6MM8eFMKGvvknrET+IJ+zlJSYTEOUG6PxC54VTwEPbeSz
 zoAyNd8G6pGDUzPt8ae5PtEyItxJbQ1mztYI34YcVehcwosbhK8IfCv0OepQoTAlNEbnoc8elnM
 H5AxcWiEPYnc5kE/jTv8r60M77dEzc6XoxpjVfzFNzaarGIyQG6wkyugS8YdRMV6KVnvd3P1Omd
 LY8Y3vcKN7Wudir//9cI96CCDHSD3BiN+mNIl02YTqNwm3wtwikbwFkavTg3V6Ykzo33OwWr6sw
 uULILjh5+tmE8IkLcjj0jZ2HgKLnPYwkHn8YZc8eMOifngsuO41cPNKc2d/q/k6M7i/WibODPEx
 xpFqUpqeD6KD9F6C+
X-Received: by 2002:a17:90b:240f:b0:3b3:fd13:6846 with SMTP id
 98e67ed59e1d1-3b3fd137820mr62a91.11.1795033668258; 
 Wed, 18 Nov 2026 12:27:48 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3f708ae2csm785605a91.15.2026.11.18.12.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 12:27:47 -0800 (PST)
Message-ID: <1224bde0-91d8-4efe-8be4-bcd83afc450e@linaro.org>
Date: Wed, 18 Nov 2026 12:27:46 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] tcg: Support maxsz=4 in GVEC descriptors
To: WX Chen <wxchen0913@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Tao Tang <tangtao1634@phytium.com.cn>
References: <20261118-bug-issue-rvv-vlen32-gvec-v1-1-c15cf05de6bc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261118-bug-issue-rvv-vlen32-gvec-v1-1-c15cf05de6bc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 23:09, WX Chen wrote:
> This patch adds support for oprsz = maxsz = 4 in GVEC descriptors.
> 
> The MAXSZ field currently encodes and decodes sizes as follows:
> 
>      encoded_maxsz = maxsz / 8 - 1
>      maxsz = (encoded_maxsz + 1) * 8
> 
> Field value 2 would represent 24 bytes. However, maxsz values of
> 16 bytes or more must be multiples of 16, so this field value is
> unused by valid descriptors.
> 
> In this patch, we reuse MAXSZ field value 2 to represent 4 bytes.
> As for oprsz, OPRSZ field value 2 already means "use MAXSZ", allowing
> oprsz to follow maxsz without changing the OPRSZ decoding logic.
> 
> All existing valid descriptor encodings are preserved. The size
> and alignment requirements for generic GVEC operation expansion
> remain unchanged.

The obvious follow-up question is: what are you going to do with it?
Is this intended only for use within riscv tcg helper functions?

At minimum you need to adjust assertions elsewhere in tcg/ which 
currently rely on the assertions that you're removing/moving.


r~

