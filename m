Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0563C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 20:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twoAA-0007TT-3v; Mon, 24 Mar 2025 16:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twoA0-0007SV-84
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:12:38 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1two9x-0002xJ-Nk
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:12:35 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6e8ec399427so38148046d6.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742847151; x=1743451951; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ez0pzd+7c4uCEKX5ibULFAlWWYkx2FHZv8ED8NrATt4=;
 b=PRE/sR+fptSB09TJa5RdoOF3eGTdL647hjV/Ki0koPScufLHJziBLjCUw+aBo43t7p
 RJPuw/9wJ1490m5/MPUfJbztvg5d9/sL3B2BXcwZXhzUEI5UjsPBndESSxrYeW9SZXq8
 afTdBZ3IdLbBLWfS6L5SoXzpmjRRAfJqrUeGgM4HsuEhJ8lW8/BZXX5tq4Xf6RH6K+oh
 04SItjPNJC0BH2hg0EubSa30s9SkvdBGH/yS+B5L/Qy2mnbxbVXs2iNhx482fhRqQ6JM
 8gtP4XTqC/bscadmOYh/9f4t173RCGdaUtTnas9uwSAoIme91RFSrYGdfvTN6s9ER0/A
 BRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742847151; x=1743451951;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ez0pzd+7c4uCEKX5ibULFAlWWYkx2FHZv8ED8NrATt4=;
 b=w8TaRHBlbXEQTtzEj7xg+FwTcB/3w7teNyRxgqMRo9xadF7IpI+GwhGCr3yA4qbBMG
 c6gbnZJb1eSi/SvK1I85qq7+yYDGmsiZPn+FX8mH4dBWRxjYgdKCXIAc8SebUKOUaeVy
 fwTczw1WSFLznurwUru8Mea6u7Z+hwAw9LoxfXgm14RiUakoWuEWTCi459QLVE7LeiOU
 /s23B87cPVRT9mLsA8OLCpkPuCFTuMkGXM9FNbcOrzpVByB5wDR1Jcuz00YFYjOBwOcj
 UeZSOyb4ogxQwz+fGheuoqTqpY9cHvjFpwP+pQuFktzRfnoDcYxRwLSliHvpMSxLAKkz
 L8Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFvc4dELTVgFONqXhCBRgF1O/CXt9If00bBXwG3UDPE3mWKX5BAbzogfcvAp7SgcL2dK6VmFFBFcHn@nongnu.org
X-Gm-Message-State: AOJu0YytNVgRWWvANFbThea7K6jcpkrIOgYbu+vzhB3IWzuFq/Dgg2tu
 KuUofTQQscvrfXzzzvsRe7Y5+lxvvIPp5gN2ixgPN1fEbdyztDHuaiTvT+eBxQg=
X-Gm-Gg: ASbGnctym5zVQFmVrkVqjGOpypcSyk1eycLV16m2VgxXBzORxFea6Tmk4GhyiMbYDjr
 p1GsLkrv4PpUAkgbt/GtNPd+mUZkDJddLomFUx4RTTD/9snGUpdUm4HhIeS15imMxc8aDhINJZg
 e4jixeQM/W7cLDDMUDGybeCCjYgoC1g144fjSoQMOiD+PB/bq5iYRQAEfA5XtVt2NpnzxnbIogd
 3qQRyzuKUigBPBeBPe42WvHYiDsD7Xs8bWKiH0G81icbUxzyKbctNJl32t3zApCNrfYLr5Cs+T2
 6KkdChgwhoiufq4UlIAd5bcYzoRevIyhXVbQCFRCmtwQzuM3Cz4aU5TAmclXAE4=
X-Google-Smtp-Source: AGHT+IGWroD0U5fnTuPu0RncU4s9DPRGrzHEZQuGp8S+HdfHkRwQsVthLdx/kiIBbtL1bGW0jelfBA==
X-Received: by 2002:a05:6214:48e:b0:6e8:ee44:ce9f with SMTP id
 6a1803df08f44-6eb3f2e47dbmr218106676d6.20.1742847151263; 
 Mon, 24 Mar 2025 13:12:31 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:319a:7f6b:e6fe:90fa])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eb3ef1f81dsm48036836d6.38.2025.03.24.13.12.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:12:30 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Paolo Bonzini'" <pbonzini@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301172045.1295412-7-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 6/8] target/hexagon: add build config for softmmu
Date: Mon, 24 Mar 2025 15:12:29 -0500
Message-ID: <04c101db9cf9$126dff30$3749fd90$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQBnRK9gH0BRY5vrCSddsvIJtQ/qNAGwwbE4tl3gdMA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250324-4, 3/24/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Saturday, March 1, 2025 11:21 AM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 6/8] target/hexagon: add build config for softmmu
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


