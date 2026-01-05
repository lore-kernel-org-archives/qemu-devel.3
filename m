Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3E4CD0423
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 23:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vctvg-0000Hw-Ax; Mon, 05 Jan 2026 18:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1vctX3-0005ij-O5
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 17:58:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1vctX2-0000gR-3J
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 17:58:37 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 605JBg3K936780
 for <qemu-devel@nongnu.org>; Mon, 5 Jan 2026 22:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BrOkH7ccM8CbzKXLUYo2Z/xp
 EEAVGtV0zqGR9y+ZkgQ=; b=Qxb9nIX88E0WY0sPdBpqgER3OuhZQ212P+li5L+x
 aQ9MIqIrHePSZ4pgi/kU3AAEMZS2qHna5Q3hyWdZQ67xhrLZ6J9Y+LOmsxmTdlJf
 pBXQmLdG37VuZlOY0x3Vx4ADRtQ30ySAq2ZOwjCA1WiyvF+HpeYnvm2tHKc/kyV9
 SJ7T5U0njA3huFF9QFUxwmBNPjohWTI3v4IMZGwOkzhf9eDCBL+9w9HAnNVIkVBf
 /zVWitndM6JbeqHUQuIRju4d/yk51oRm2b9VG+9tYbLSTkDYzIl/efGDIu29nXoA
 PiDQowzQLblCxPU+XXFAdG6qSPhVO2eovgtBSDdzFaDIQw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgbnv9y29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 22:58:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a13be531b2so11275355ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 14:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767653913; x=1768258713; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BrOkH7ccM8CbzKXLUYo2Z/xpEEAVGtV0zqGR9y+ZkgQ=;
 b=c5RL2C/A3nHxqWbq82czdBZ1xIgQ4fVtqQ/HlYlc+LK+kZpvMbenaz1s9YjTBSSAF8
 +lP9gkAWvjThRJBYNiu8Wqt/U3paJlvTo/PlhoXBqVLgYQc6wOsEpZhqKT7bjJPlskXS
 6A3qMcMcUpI3H8VFzX+FdhcQh7X3nfw37X77/d2cWu/NP/5fimPaLuZ01mTMhygrpLOi
 WEQvda6NvZ6PmgOLrP/LEYUziwrRtqD+ZLgNnY7XI5/HTLfPhUc5zA+TF+fSHxKvvX1f
 t+RTXS49ZuDeausE1Tme5reyGFsYHuKyTuSk4/m9bq8A6A1/v9Zdh+qClam1pZZ5RaKK
 Vf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767653913; x=1768258713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BrOkH7ccM8CbzKXLUYo2Z/xpEEAVGtV0zqGR9y+ZkgQ=;
 b=LZLDdyHjYR7DBtEB7ArAyurd7IRkwXd0H9XqxQFJ4VW4HYA/XDunB5ze7RpfSjfXFl
 HgMhu4jei/Yb+mtxarqWcV1DE1MReYn3YBFTIS5tEdTt8BVqOTOOI5FJ3vb4YusSLkKR
 4KOHBkAH9YwzKB3XwYl7o1MVPAhyaIOhEg/lLYkvTpd7vFVOKLgrTG2oHAYnJt+muXq/
 /OVtKfRGB+4QL55uYyumJfAj/DiW8PbzcgJsF/9IWwmwd7BzhL4EiPAVlZT2JTOK7iIc
 Ij93RSq0tRQwkQtj7jgPl/7Drxu/69HnTGVdw1kn8ouyC48PJA1PiJMfrbP9tY2pKbvQ
 TNUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7muGobK9YIXlf/ESAFJDE55I9NhcjPPcDVa19kbkyYhrKOeoI9Qyj8sNshYK1p6khI58cL6txpMly@nongnu.org
X-Gm-Message-State: AOJu0YwPUld+57VPrZaNZwVQOpTtu8QlOzMCDbi64El5OIKfSLHnUpBF
 WlC6Mjv4/J9WiC9Vu5sH8l7JYC4xNGoePYefV+H5f5gxqGfY+3qVEZJuM+4N51gT9/g1Ydca0Sp
 L+XyCcb/rIyrqpt6qWqtBI1fz4rQAlKpC3qagqp/c4uTocuHHD7h0AlpwnA==
X-Gm-Gg: AY/fxX4kBHwQkFp4feCAOaIpSqXkPE0cNaB01kx3Lr0I7DlTeRx/l6wmPtBHLJvxzXD
 4w4mwyA6Mt/rNG639ma1EGugQzzudK7OOwgHA8jG8XUg+kAxO21FnO0obDyTGira/kkQMZPa+Lp
 f0lbZG3xzoOtNegPMUDqsZhERph6PiGGe53IbeXsWxYg4ttXcZLWLVXOYz4NMoSwqU+1TcdqYNQ
 MbwGZ+2wmHBKBUvwbdTrHcKV9Iqm9gPs9SKcPGGF0ZrG26tWHImuP1kHr58oSOQ1Pcf4w7vm9Tq
 8aHE7k7/NDnz1HjKtIS9MxXuE8xWpWzeM4UqBfShrk8w3tNUgW3UpANCDzQqG2Tj7V0DpBLkz5L
 bJVqjM8JA/+IuWy+8EVY=
X-Received: by 2002:a05:7022:2493:b0:11b:b179:6e17 with SMTP id
 a92af1059eb24-121f18ea0bbmr964150c88.34.1767653912622; 
 Mon, 05 Jan 2026 14:58:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG83skdhESO/I1VZpHGHpNLFSrAU5JeKENs5FarzhWOFdptljThjU2UjRiVr0ucAJPBxC20bQ==
X-Received: by 2002:a05:7022:2493:b0:11b:b179:6e17 with SMTP id
 a92af1059eb24-121f18ea0bbmr964118c88.34.1767653912008; 
 Mon, 05 Jan 2026 14:58:32 -0800 (PST)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121f243421esm798885c88.2.2026.01.05.14.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 14:58:31 -0800 (PST)
Date: Mon, 5 Jan 2026 16:58:30 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Kito Cheng <kito.cheng@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 kito.cheng@gmail.com, daniel.barboza@oss.qualcomm.com
Subject: Re: [PATCH 0/5] target/riscv: Add arch= CPU property for ISA
 configuration
Message-ID: <v7ndgqzd2ubslllzddyhcsim7a3vsuldaj4f3xj5enahzo6zye@6eagodokjcpb>
References: <20260105105940.3567112-1-kito.cheng@sifive.com>
 <bc812773-1a09-4541-ae6d-7a6d7327b6a5@ventanamicro.com>
 <CALLt3Tig9WLNxfHDKKBzpHz908mZWRACioQWoxfjMk5p7eVVbQ@mail.gmail.com>
 <f469e4da-fa21-42bf-ae36-cf2235e47b97@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f469e4da-fa21-42bf-ae36-cf2235e47b97@ventanamicro.com>
X-Authority-Analysis: v=2.4 cv=I5Vohdgg c=1 sm=1 tr=0 ts=695c4219 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=uEawdTd9uqfdr34Dze8A:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: v6dGC2sgmDBgtZgXi_hQM_aXcXIzrG_n
X-Proofpoint-ORIG-GUID: v6dGC2sgmDBgtZgXi_hQM_aXcXIzrG_n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE5OCBTYWx0ZWRfX+gwBa+JZ4G4Y
 hRJ2WsdyM0nJcFPLjR5X0Y1jZUqGqtxGqjpNhEojIa87v1XaGimME+nn1KxscECCGLJv+Aih3xI
 SxFelTMT6mSzwn3f9haJsFk0hECaOKcO8G86BRb2M4cYpr5jzvldt865Dgel4dsJxJrJ1QSZ5+N
 ac+N+/PmesSHp+5pftTQIWPI8lxRsuTAB6Ha0kshRV+aMpEuWyI3feQeTqxxM7kWME8FN/pPUYB
 dIEWrLxFIecpTJBTMAcZhC2zaxkqg2ijEdIhgPeL6Iy30KawhT2SWggcx11fsGyqyIxI+XhfCnJ
 ZCbqN5cxm33ipLAmmFY++BdwobK/HKniZBmKGiMncvF6fmXpJVFksgtRW0GZTUy/W4eDc9GgbG3
 CtOKwYflYIXtVlsHfSpSWaDwuw0I7yQ488bjH6FMMlftztjEa6HubXBQ5QLowX39bkgY5YCs7UT
 /efafYiynH5d7/H3WFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050198
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 05 Jan 2026 18:24:02 -0500
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

On Mon, Jan 05, 2026 at 11:13:50AM -0300, Daniel Henrique Barboza wrote:
...
> Maybe there's an argument for supporting arch=ISA_STR in its entirely instead of
> cherry-picking what we want.

I don't think so. Focusing on adopting profiles to describe large
extension sets is the way to go in order to reduce extension management
pain. The toolchains should be doing the same.

> 
> In the end the discussion you're prompting here is whether do we want/need to
> implement and support an alternative way of enabling extensions, and in this
> case one that is more compatible with the rest of the SW stack we use in the
> RISC-V land.

riscv qemu should be striving to have a single consistent interface for
enabling extensions (cpufeatures) across all architectures. I don't think
we should support multiple description mechanisms nor anything that is
riscv unique. We also want boolean properties whenever possible as that
simplifies interfaces like cpu-model-expansion.

Users that prefer the ISA string are always free to write an ISA string to
qemu cpu property conversion script. qemu should never rename an
extension, so it should be a simple 's/_/,/g' and additions of '=on'. If
we do have special cases for naming, then I suggest we immediately add the
correct names and deprecate the incorrect ones.

Thanks,
drew

