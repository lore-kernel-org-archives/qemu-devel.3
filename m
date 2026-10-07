Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4231BCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEYN2-0003aa-Bz; Wed, 07 Oct 2026 16:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYN1-0003aN-3q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:36:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYMy-0004Na-Rq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:36:10 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697JO4Jk658433
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 20:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tincLlY51BeBIO8WOMtjDuc7KZgNUNib8lMdX2hKPyA=; b=pD/lEXFJHmskFGd6
 SZ9/ICNLurhdHV7yR70cZqsASixuUN+HlKzR50ixfgP9b6ZC83To/06jDkiZ3bqO
 DfoMRlOy8iPZfJ8dzeDuLAVzd7rCOymb1lhTM21MxIJEdzMgXmfeeDzLVJUTJBXp
 XsKwNqCpYMrXLtL1pKphEx/E0Pi0Z80UHkAzxDFlRNUWOXEJplo8N3785neEuWxS
 XUXuXesDfWac2Is+SWnvDZJE2nbNqsotFF1p4Ab5S710o3Vk6pq2WQBEftM/Hkdh
 rfkNsk5sarosVOLioN7rkiIUxGavDS0rObHZ5QbOzkSpy6ZesCcb3Uh3wt9IHDNO
 3kSYdg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5pv71pyu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 20:36:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35156644c96so1668929eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791405366; x=1792010166; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tincLlY51BeBIO8WOMtjDuc7KZgNUNib8lMdX2hKPyA=;
 b=NxGRTNe7an0XOqIXTv+BhMTPKZXUndhJmdMHIFUch1xOFVjDgyyxJkX5TeMuN6SfFj
 HscNBW1MD2Eev82tIO6JGQ0SWTKYESADDLiYYnjLBV7D64kvR9MpQaOkP8Y8GxqR/fCq
 PpXC70pH+YAoKXVbBBjXUtZR3IODg+iPnsPC91dVNLzNu8eq1nZyQV6C434uT4CCY5cU
 Z9Lzs+tBmInfgxP5YM/dH5kRm+Lp6o4RRXummT4VjDbpFyvaP5ZrmDkeQLFnu/VFHXil
 54mrTmLEq17qZ80wzzV/1S4rnCul3gvPsR7Q0iWYx546+Q0RVXLCohC6QepHOdetRPvw
 L2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791405366; x=1792010166;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tincLlY51BeBIO8WOMtjDuc7KZgNUNib8lMdX2hKPyA=;
 b=G7iUNTUu7Gni/384R/GY7ImtE5bdLQ3m9h90j6+k1hIFcTslLUkk5lD+6LUrtMHfnZ
 DtwXu1kvI4gu0jcPtN5PeG5oZRE8ySjcuHGKgRvDYdKz9669C77q2DWoK5RblCILpauW
 sCmNVIbAP5kPDW2ghKDsBJmYM0w8PWVhza8jWxeeAuMSZt+dgPq1psbZJiXcnHTMA6nR
 JM448oBndz52AMp1Jpue6w91+5w3iPEx2nVLEmQN/6EmKpGVZ2ZxqQb2nlcjueUQG4vm
 OheuM9WHQV5rbpswWne81gdBdNpazxaSpnLYN3eUSznYjXTtXoFue2x/27QbPDWiQFx/
 tpNw==
X-Forwarded-Encrypted: i=1;
 AKwUvByKrmnH0rxK8+pyR4Ii+nr5a56WDE3W84Ylp2F8/VQidtCfkntMk1hPXlg8HOCHd6M2SvVWnpKf4gMQ@nongnu.org
X-Gm-Message-State: AFuF++l4U8UaGpOeS+GvEsI2B89yMr0h9cMDxnpJA0AOh/fPpAlAqkLQ
 Rd4zoaRIp0Ie6MG5mM+vBsJRHA0nz4vjk1xv5AEkm+mRy1ETgnJoyIa4buDICIcDjih2pqoaDk7
 zNnTgo4mrWaTHQ8qW2hSiCOqAEXVaIjYEpF37tXDXZh8Euo0DiduL6844wQ==
X-Gm-Gg: AYBFou341FOuOp3Gm4fu/3Cl42ey5CkBNBllUg9BQT5ksu80LBvgWqOCBdLCq43wau2
 SP0j2KgrRU6RetB5qCEevp295Bl9+l3u/n32HUdz1qlSfzwfSLQszXDfcyeCQCAQKA3N9Y44E9n
 Vn5bI0ld1gSPCQD57svKVeipif8aBAk0vZmB1qBy5hQnQdNX/EZScN7eengcGfUFKFOanyFzUoW
 WagdPcMA70cQRzGEnZcizteHOwshEn0ZQFEZ90rzWUoEZwjBBtQaDjenLdiPFes4okynAAfJv/8
 dWThOUwtvfwrERTq1ZdY2/Qb85I+NAnX7WDCpXRwJpgNr+XZKZ7CXOgZ/2sY/2dRFRKjEaRbkWJ
 KtkuwwQTSuj6X/9MfS5tGUiH+tINEo5vcINi5t9bY/nsO4+iCkI46C2sak9JkhLhr8FoBfA==
X-Received: by 2002:a05:701b:270e:b0:144:eb3f:563a with SMTP id
 a92af1059eb24-165a64014d5mr311743c88.15.1791405365903; 
 Wed, 07 Oct 2026 13:36:05 -0700 (PDT)
X-Received: by 2002:a05:701b:270e:b0:144:eb3f:563a with SMTP id
 a92af1059eb24-165a64014d5mr311691c88.15.1791405364944; 
 Wed, 07 Oct 2026 13:36:04 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515afa61e8sm10632193eec.22.2026.10.07.13.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 13:36:04 -0700 (PDT)
Message-ID: <51f90aaa-e37b-490f-a207-a31f14407df8@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 13:36:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] target-info: Replace handwritten architecture checks
 with generated code
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-8-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007115253.328-8-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4MiBTYWx0ZWRfX4Mq6ixf6pbxk
 B7w3wSNCaxmTnsvo1Df8Pdkp7kohhGln0uXpKmBPsMpB4xUxC/6O+N01OgajNyHbZCfGUb7hWSo
 A44BpdC9zyv1Z2/9MVDGndbSuu/crmA=
X-Authority-Analysis: v=2.4 cv=J4I/fwnS c=1 sm=1 tr=0 ts=6ac6ad36 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=LWoprZIH4OQ42_rLm-wA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: PkE9iVmmcEMldOz0uUEOqJU5scSGbv-n
X-Proofpoint-GUID: PkE9iVmmcEMldOz0uUEOqJU5scSGbv-n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4MiBTYWx0ZWRfX20okdVG/Pb+x
 bUe5stczFv5x/yZ4h49Q9hFPViono71rC0GBroPRq5hvvkcek3lYF3xMrcRiZ15mCeW6xGPt/K2
 f99/CZWEgdUX2oqJ949j2HK2RyVs3SwSWLPYXl9YddT7rrwkeLsys8Z5WWCjHY3eYjmzaX9sZGB
 um6AsLQxuyZ/29415R/QpDdX951CHQ/fUaf+6jyLZk943SFtiOB82SPdV5mHGbhmJMTLLymwLA4
 GTSILoh6wZo7KyAoLsi+1lOVA9PMJdVjbVePfBnrU1HKcmiYOR4aBFUg+4XImZ+t0IOJjpEUcXM
 r7zdZBqj/T/PKr0dx644erPxAXgQ4iiKQPJZ7qvR2VRBLOXFohyEReBmfPAaSU0BZCW7UbX+i46
 3AzXvEpu8EzKrpu0dB5eDNTBnlU+IXRNoa5KJ8WjTurPllciv7eQO6zRHknLelkF3NATlzW2OTF
 caBxuxSgihlUzjHa1DA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/7/2026 4:48 AM, Yonggang Luo wrote:
> Add scripts/gen-target-info.py to generate declarations and definitions
> for exact-target and base-family architecture checks from system target
> names and their TARGET_BASE_ARCH values.
> 
> Provide target_is_<arch>() and target_is_base_<family>() checks for an
> explicit TargetInfo. Retain target_<arch>() and target_base_<family>()
> as wrappers using the current target.
> 
> Wire the generator into Meson using all system target definitions so
> the available checks do not depend on --target-list.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/qemu/target-info.h | 76 ++++-------------------------
>  meson.build                | 16 ++++++
>  scripts/gen-target-info.py | 99 ++++++++++++++++++++++++++++++++++++++
>  target-info.c              | 62 +-----------------------
>  4 files changed, 125 insertions(+), 128 deletions(-)
>  create mode 100644 scripts/gen-target-info.py
> 

If I had to pick between simple and manual boilerplate, and a python
script generating C code, I would tend to choose the former.
In this case, the set of targets is bounded, so manual code is really
the way to go for me.

If the repetition is really unbearable, macros are a way to deal with
this. However, note that we will not need all the target_X to be
defined, so I would prefer to not see any new variant added as long as
it's not used.

Regards,
Pierrick

