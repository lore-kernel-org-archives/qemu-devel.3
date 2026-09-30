Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A99CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSA-0000tG-Vl; Wed, 30 Sep 2026 12:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxS3-0000pV-8V
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:46:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxS1-00031G-Sr
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:46:39 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UFXNOR195084
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ysrwWxf5sZ4v2MvUwxEblE3A4HAJJGOfs++j1EfexOQ=; b=WHEys0WeMP2sBxlo
 u2h96Dbkbp5/+mFyz3LpgUYyy2mJJo1LjzoT/yFbFKmTw6XXcGCb4Hye96vxAvA5
 EhWsk4bCcWccJdG8ljzhfxyqs/MFT5mS5yjwdSNgvzQT1OLnRnJwS0xZRkcGoLcQ
 pMbHgSmWpJmsv5hfyMaK/APaahAmDV/ytP9kaD+uGDLfVFCpBHzMVVyI55r4aTKf
 qj80h89+pOXoB/Rxb9EH4n6W/RGunoZuQ21MennjqKhM9kVdB7gUvnJI55CnNYg1
 VYGS4kuObm9AXaNdJvaFKvNcsDrIBcWmmPZgOEAaxkr6kP7drpl3YgItzFuFclYp
 ppldGQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h155vra6t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:46:36 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7bf257e7b5eso328783137.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790786796; x=1791391596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ysrwWxf5sZ4v2MvUwxEblE3A4HAJJGOfs++j1EfexOQ=;
 b=f52VH5ViQOC6Dk2QaFk+eH5gZMBR/BJyIpV85o1gX1XW39YbfN+fergZNSv9ILGRRX
 aqPiTiZy+tevrM56JUiX6z2YG/QWCbZd7XzbxVJe88/pBwf217VQeqr+kVLSa7FVP2bl
 RNlH5irL+oxF1SQBUwIcAHF2tkKRffjUn+xHFpvQwoFXFYvyCICY0uYYAxnwPdVVnaTJ
 I27HvLnbZNiGKoqIlDLC5jr2vMlO4KDM/9SBvgPcKJQmFEreQZcUfBfqJIJLtl2sG63p
 k8pJcd7q/x4Gewo35VvKgt9IbLSVZUiDIsMHWiglfNFp40q6FX0ZTekrkMY/NY42O7DF
 FGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786796; x=1791391596;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ysrwWxf5sZ4v2MvUwxEblE3A4HAJJGOfs++j1EfexOQ=;
 b=0IWGYrZ/Ax1TK9moMfEQKGTshzapHwk1ejEg6CZksjTCj8zccBsYxi4mhxsATMke8/
 1wzZPAkdiR6yTvOn5s95KMAmjW4ig+ot3fKjMkaVzRVQxa/lzMsazHDhP7ULBOYHUHyC
 Pn4YgcXIKUMFKFjupMlt3jbK+byYLkMC6/cjcEaFnNUhcge70TQD5PZjGmEnhwE1BaNU
 A+8c30PyuZ746EDmz+giaFwqMHpv4rHHlqen9avQogttEb0nFwoAc5rG61pmIalEKMMb
 MMpr6agGCuuvEqe+BPgmIS+IIbEeKsQ26ftnLXoiZku3+dbqYm0VR/FDiGrBXi8Yho/9
 Yuvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaSn0ZvoCYb5X3Oj0MmP1xiMksQpZPkVlFVcmpQCa27YHqsq/cK687lteWqjanw1YUre09mnw0rv+J@nongnu.org
X-Gm-Message-State: AFq9FYI74rnt0OVmwntYPTsb5la0xHUNR1kIrHflV5xI7x5G4pp/oT54
 1ktX+NU/jryjUXPkhv765H0MzXIZo4OjeBC0WFxHf+lDi8TnjF8LYLcqgjDQoUWODO5xQXdm0NB
 CoCHIcv1ICMcTcAn0lH1XweJXXbkWACJMkPuHqellVEa29j9VzKLkcR5bGQ==
X-Gm-Gg: AYBFou1hHx+vR+1p2IYnms2pVSD7ihiwQELfPWHvD/fcyLXhVJWdA8hg2rbdjvInlkh
 MNVWygUPCEypcVsucP4loCZZyAnruDJKTNMGYtQfv4metZmOPo9vHEjDhAInWySRbdI6l2LtAYh
 hhnvqQJ1lFmiE53hDNFvSYF7ks8BOi+mNqccNw/7ajYAjnKHVdPPsZSOSFbTKwTxDuIe+JdKrL6
 XqNGWkSwrTifJXQgbjA6H+xIhoKSnMwEb/dhODXmVxM4yhaE8GEGH4cJK8m/W22Ef1gqEHTfRd1
 RqGLgUngNa3lcyeo3BxfFabMLJ4OWTPGPDmvmusZ1D+q3zChRsdodYyTGs3zBcbKnND20sF27rL
 6UW25JOQOQsFi54aMDP4=
X-Received: by 2002:a05:6102:38cd:b0:7b5:b51:63ae with SMTP id
 ada2fe7eead31-7be73e957d4mr635927137.26.1790786795656; 
 Wed, 30 Sep 2026 09:46:35 -0700 (PDT)
X-Received: by 2002:a05:6102:38cd:b0:7b5:b51:63ae with SMTP id
 ada2fe7eead31-7be73e957d4mr635914137.26.1790786795176; 
 Wed, 30 Sep 2026 09:46:35 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb60733sm4009665e9.2.2026.09.30.09.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:46:34 -0700 (PDT)
Message-ID: <c11d70c3-87a5-4bbf-b571-dbe4232cee7d@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/27] hw/usb/dev-smartcard-reader: use usb_packet_size()
 accessor
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <20260805-smartcard-fixes-v1-24-187ee9122441@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805-smartcard-fixes-v1-24-187ee9122441@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX3EqLqmdjq4WA
 l+C4yYdiWC4pfqPRuxvyyGllAo7CRIvUOcA1rKGSWNCq9xBCfysFwI2t+YI7b4M9JMgz4mYTHA1
 uSsmcDCLi6H/oW3Bqu7otYWlIHkMIWc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX0XITfYDHvwPv
 mJ0Z+W0jFHtbDb6jralAa0gPQ1ef0jCN9dh3EO6yj4tvKHh6MCm4rBVGXMioa9owfGJmwWnq/By
 0PPvkSfrDDTRlXezuZvFbuONo7/JV6YnZGEJ+ge2ffFeqaQ3oUeoaWDExx1HPkLaXoGDVo2OdEk
 e1qmTtHQDXBc7cD8enAXHdke7d42LJCLY4BRZwubUaAj2pPPw4kj1X7+wzZOmq1hl4m8F7/waSM
 3LMbQqtA5nJwTzmMzacq/m1XNxW7YlkJXDt2WiEmVXzMbCyDrASdeIoYTFAEGIb3jkq53hJw85S
 H68zbpNMZzxRuz3nf4UwR/0cqY2sOwtkCHej67AK5ixGs2KQQsPjVx9gTs/gc95E2HSPc0IuK8P
 2cxpZ8XM6ff7gfziogSv1L4bYB59PAxSpfhvPZGCmlKttLbLLYeZrDJOWuf1vqIvr85QPMcLHzP
 nUzOkXC82RPawjkIyyw==
X-Proofpoint-ORIG-GUID: K0UXuzKM1v6IrNBy12bZKrDHMnt3jLLL
X-Proofpoint-GUID: K0UXuzKM1v6IrNBy12bZKrDHMnt3jLLL
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6abd3cec cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=J71Je4g08bpL2Qf89IAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300066
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

On 2026-08-05 13:51, Marc-AndrÃ© Lureau wrote:
> Replace direct p->iov.size accesses with usb_packet_size(), which
> correctly handles combined packets.
> 
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/dev-smartcard-reader.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

