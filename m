Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68F6CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblb2-0003DN-5y; Mon, 22 Jun 2026 16:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblb0-0003DF-6r
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:50:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblay-0006j6-9E
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:50:17 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJb9Nf2122402
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h9fprs1GwXg+KvxE9riT8aO9T9+bplN4BckEciczOtM=; b=Jo5/KBCfq5cKvmGX
 fXYUsyUKNPPEF3y0oj1C5UQrD/lNFJ5iRK9Ot10bxb7qmytDQTOuBCDPgdyEtl0C
 NDAKyy3Wvs8qo7P11rGCYQ8NlItOVIC+JoNeGm6Sb80HoDr6BMyUxw7YDVLmbuyg
 JHd/ATZuCKdiRMUS82IJX8Q1dvGgYIAfCrla3WItv0RC1tseilwGwQ/LgmaqKILR
 Pg2NvAVV1L6jI0ItdjYvOmPoxSTYarSiHtehAgggQtRBFpJv9/jsb3jb2IZbkO22
 boMILAK3QgHWWF1zuIye74JepVxZM5JiPMUlE2yeLORoTu3+1jSIlfJ+2ayx65zj
 JbnrbA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n41nky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:50:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8dbe3bd27d8so90400926d6.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782161414; x=1782766214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h9fprs1GwXg+KvxE9riT8aO9T9+bplN4BckEciczOtM=;
 b=L0iqMDjJ0etiv1fYzM3z19omH5jXkSiqP1sffvj/62TyYBIvwWhNoiuqLJu8Fpa59T
 SXOBdrmT+G8bAtHztLMBH+jm6AewBMnfTGgKYrYijnW4VuNZl6MtiCeLh1M4iDmv41RW
 vb99ChsKAuVfi917Q1+KL/XRDIdrldOtXx9W6Rc6OBmmCTwnw+9pdd5umerwYT5mAvdM
 fZMOV3CUlruU70DXyqyP1w/H7aWT2CymbrCB+JsXFssl59nzjbiTOEMs01z6Ed8tCYNK
 j7en08qrYDWUQnTslL63R6Nzq5orrlv+pDu5RTi9Q3g+t0uJWdpysXGkpzmKJR/f9t5+
 pdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782161414; x=1782766214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h9fprs1GwXg+KvxE9riT8aO9T9+bplN4BckEciczOtM=;
 b=dmityQldjGL/nDF1T1zKcQrIUrwAy9gCMD8/671LNGCwRVeUb1snoSRwmiVLbGDddH
 Z/SDRayJtZuxZZJAYyJX4E7eYm+v/mTqec5BiOajcP0nQLrHFWvnvoGEVaEdIcMv/u08
 nCKG43ZMvPIBBNc0TQ0Tv8eSABeSUBut5l/sRY41LVbUCLqMBN4w0o4LXyGjC87qFhmC
 LORFd0ZcrYko4SwUCNJ6vWUlz7QretOGs35dYgX4iewVDMEifb8QWjcQErpQHrDp9a7R
 IuwryO7A3FZUjmRV/gYDV61vdP8i2qQlGtW5p+GxnJWo6uDwNDniizJ5auqcQnn8WSJm
 HE0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bU8bzdivQGM3fYK2Ayhim03B2nayS0FnjslFvBE1PIfgnJODicQZsRlh/k6R3CBHtNRU004GrUc95@nongnu.org
X-Gm-Message-State: AOJu0Ywj3K7z5dmGeUKtl6O1fJeZ85d6MjhLxXkcJvYWQqR/R5G5dXaS
 oJdUILLEwJZ9+4J/d6WNgBNFb0j8JVU6DBCmJ+r6XY3muxRtGK41dp0BPXa0hXwFDHxGEoXoa3u
 AO+RwuyUB2kbTCbyJoehWwKc7lV5aw1hGRFgCStgCfTnXOd6mN9rEjZDDgQ==
X-Gm-Gg: AfdE7cmd5op+5RBxrmyABPBTRndDt7DuBjjCuBaNGmv9Na1Trfs7EdnPjgxO/PXuC7W
 bmBxE7YfHH1iif1hLTJYVgZPtzsC7cWhxSiB9V+LC8SBfKxfgWZaMQYVPMF13T2/0L59gLJFBjS
 gk0ArTT5hze0I+X/ELGJRCt2YLQLmfpVEHjG1z38K/+k3vCOyeW53JpG+HsU0PNmbAlCBSzTSys
 FTYV4eORhyJu3dZAZUsxBxMgy/G+bECAMcIHTujsd54QRuZbQRONaxBofg8HWLFrnWXuO9lG69a
 rGvArHWfcvFTs37x8WC3N3EuIaQ1+Fk2uRBYoxwNaUTVCUcl9+W1gLVYUP4gOdqEKxim+7CT44N
 unmL/pY/UO047+j9+DAY+vBTAYuRjs630AMXO8nas+NbvHUFxf84TaIaCSK4YkQ==
X-Received: by 2002:a05:620a:290e:b0:911:ddfd:634a with SMTP id
 af79cd13be357-9208f15dfcamr2521665185a.4.1782161413799; 
 Mon, 22 Jun 2026 13:50:13 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:911:ddfd:634a with SMTP id
 af79cd13be357-9208f15dfcamr2521658885a.4.1782161413260; 
 Mon, 22 Jun 2026 13:50:13 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46667221de7sm28471703f8f.33.2026.06.22.13.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 13:50:12 -0700 (PDT)
Message-ID: <033dc4c3-6398-49c0-aaec-487927cd549c@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 22:50:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] igb: Implement Transmit Rate Limiting (TRL)
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwMSBTYWx0ZWRfX+RNLkzqlp9Z9
 9A7yd8sD6r3H1qhwvDNFVl8a1Xwxj7fZdRub8vrkHZkR1rgGI0LAidWe0vCVKKJWj99OoOMeluB
 /tGeGY9zTpQDN9POU0gjgD0t90D7JyQ=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a39a006 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=mDV3o1hIAAAA:8 a=1XWaLZrsAAAA:8 a=aPRP8MHun3OBjw6ZgZAA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: KtGOug9VCbteRlDEe5Plx9gCcff6QMoq
X-Proofpoint-GUID: KtGOug9VCbteRlDEe5Plx9gCcff6QMoq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwMSBTYWx0ZWRfXzqLuwQfn7wMZ
 +vVWioY5rOrGWbulo/okq+DXT8fCQ+2aWbB1BrvcRqAk1LHCA1JGmHYHukVKFgbpJOZntxudNAa
 Vg2j3uYmF+KtidBA7Je7uLwV0nhyhHQ+x/JidO1nSbpNESOM6s/q7u6a12MAcpFzBwwpQK8POR1
 Px3yu3t2Dn7OxIxbM5MJXMywIvGIhj6KF+j71u9PKLTM7DspGM3d6hRoKhfknCCxceQw80zhLss
 9xv7ylWUlh+3XKtJ6tb306sPenppaSnpffM2QUdbM1yVNHs/CO7C+gxdwVGf3SqFNpvfZ5h73Su
 jBYFMIw2XaADA/drDdAdjvLxVd70JBOP2vPLqojbwWSs1CSncTnMsWgMkYdsmcxRtq+CZgL9pGJ
 msJzdulKN0QSKkf+ykbYAppedxWgYFSq0RIsip7CO20fyQut7+mCiPXizpwptj4JD6sxYhavFsU
 5Hssz7k/zW9G4IwPJrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220201
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Josh,

On 22/6/26 21:05, Josh Hilke wrote:
> This is v7 of a patch series implementing the Transmit Rate Limiter (TRL) feature for
> the Intel 82576 (igb) network device emulation in QEMU.
> 
> v6: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg04562.html
> 
> Changelog:
> 
> v7:
>    - Inline igb_trl_disable() since it's only needed in one location,
>      igb_core_set_link_status().
>    - Fix indentation in QTest.
>    - Don't set PCI_MSIX_ENTRY_CTRL_MASKBIT when clearing pending
>      interrupts in Qtest.
>    - Fold calculations igb_trl_calculate_delay() to simplify logic.

I already reviewed some of these in your v4, should I review
the patches again?

> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
> Josh Hilke (7):
>        igb: Define TRL registers and core state
>        igb: Add VMState support for TRL state
>        igb: Implement TRL register write and configuration
>        igb: Refactor TX path to return processed byte count
>        igb: Implement TRL throttling and timer resumption
>        igb: Add QTest for Transmit Rate Limiter register multiplexing
>        igb: Add QTest for Transmit Rate Limiter traffic throttling
> 
>   hw/net/igb.c           |  43 +++++++++++
>   hw/net/igb_common.h    |   1 +
>   hw/net/igb_core.c      | 142 ++++++++++++++++++++++++++++++++--
>   hw/net/igb_core.h      |  12 +++
>   hw/net/igb_regs.h      |   5 ++
>   tests/qtest/igb-test.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 404 insertions(+), 5 deletions(-)
> ---
> base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
> change-id: 20260608-igb-trl-19be198da6f2
> 
> Best regards,


