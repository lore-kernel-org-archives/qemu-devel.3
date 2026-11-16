Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4192606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eRj7xS6L;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GAQ0uYXB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT47q-0004sI-Jd; Mon, 16 Nov 2026 16:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47i-0004nM-LX
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:22 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47h-0003NH-48
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:22 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLCGHd2710529
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l1IvJy8Xg22U+OXPEKbXaF3YYRNH5lDN6kRqo2dX3mA=; b=eRj7xS6LVjvPMGTJ
 N9sRR2n9+KALth9oa62qiGzd99Yw7quh1aJqYuosgwDvpJa78DGe/A4xy8fWjMAk
 4VGgWt0qNdJXnts7w7LFeitCmi1JKHVDawdcyBgOhGcN4s/tGJnEeyLRpOhySi5Q
 a+vNI5kJgYy0qaBSxPMHCTYll3hikaTgJ0DRNK6VCzNrwl6rKhBp1yZthXD+oUbh
 wlppW75oeHDr6AocoHmFvoGu56+dhdUU3vv8pb21UhjKXf/jwQJKxDUcGu7RVA0e
 gauWTKRUgQwHtbF3BCcPCdhw+8BYhRaCzkERpZfRXe3PLJkAjcQS9UweLIwSIDP3
 6gF8xQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htg0sp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so4633117eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864019; x=1795468819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l1IvJy8Xg22U+OXPEKbXaF3YYRNH5lDN6kRqo2dX3mA=;
 b=GAQ0uYXBMAwlZnRoSL7Z7RarGS6iLln/yMZ2MuCvztiIKZLowg4QA32aPQb5N1fc/6
 9nt2GNsrjU8pW8IUcdAx+X9VHdCWlN81XDSu2FPQqu5PzOeGvfUG7WlQd6oEaqfS2Bmq
 DhOGHFeLUnIqHszuNHjsCyx1wVOkCOSupAVI/5ToU3IrbfQEigPPkX7aZY5NCSsiuJjt
 3A4qGlFSzXHmeDviT7ktbW4A9be+pJD0IT64xpHQGQ1edH1EAbCdvie63EGsIv4ActUG
 SUPw1Agc0rWO0Gy27TsCajiIdE1gyqPD3d2KrTsUK0oj2QLBMZtAfDJGBL22g9v7UnPB
 oefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864019; x=1795468819;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l1IvJy8Xg22U+OXPEKbXaF3YYRNH5lDN6kRqo2dX3mA=;
 b=CamU4JLNjJJ9P1YfpwXx+SleoGrrRbL1Bk5VHFsC/ojIkcEITOroF/EKPoh99OJJPU
 3EnzqRrBwrSWDdQYDaHpHb4lC50eEKF02MNQmtHb6NFaoSoPpSlBt6KsG68JvuQymI4b
 GN2e0o9akxaZq84EOlWMT1BKlpLepJrIUee7j9ePgH2HRQ4Xw0rmmBL4Kq6ZNTKaGEMO
 rE8zXFBUspIU+rUZlVP18rQwA0Z//jIg45stoqkYf/hYchwRBHDiv44KfKc4f36NHp1m
 GQHJMKnH6l+UWw3wUhM9uBn4/CXmfWihog3ut2L/1aM4JfuLo8JiCnBkoh7BAJetjN/3
 Qp6A==
X-Forwarded-Encrypted: i=1;
 AL+hErEZmK3dwKdW24PWw/Xzb0Jiyfc1Zdh3g1GIUKCf0Y2ZdQ8mDOU+URvvAQKmaKS36YF30byPDgtaelw4@nongnu.org
X-Gm-Message-State: APuU4Z+d8uH+ypKJpn7XdRjiuE8TP+GQE/4kgt45eT3c2FhOBsqO2k1G
 cY/0GK1GnxevcdapEvsNrnqReBiGnqeTSv9jtfifLDVnG2JFZ/wZh2UjBqnwM06d1Hykr5UEfnt
 HVjRPgrWU76MYq5aR4qt3vaAY4RdbgHdMtY7KeIuu0Xa5ENNRcsDjbbGA8w==
X-Gm-Gg: AZFdTZd7HXDpXXFxr9j95LPR4Z9g5LM0dGXsDWSv4sS8Xo1LMDoKJw7qUGun6/PifJd
 7/qDI1CpwCkAfw/KLeFfRmPsF9r1GiDCThSkuRko6NsQDQ+Yy7cUXidzbJmgcWPutMvUCpH7zZ+
 Ppa2LUrcjdXZ4mdjffkk9uSoy1b8Ene65Su6fByhSo3ewh66ooics5rYdDviUBpPPZfSGaqra06
 X5QdM61tiXWaDgnlGsjyTIodRZl0p+fFurQYzjDr6u6UcOHFzFeRfaDFLQHL+o+urlaSvnCNM3r
 4ACVlfCwSZkodCTLog8ldIaoPQCuZFnrMBd14AUH2FSeqszN65vhstJTT/LOPOJPze3s+X9ZTHR
 iIeY73lwBKt51Rb5PkdezE8aXtLw2TIy7Y4tArVASPZUbEqeLeEfJTDJBy9nC/Pl5a9pYd4fHfA
 mbZszTav4H0xZBiDMM9qUeK67FCQRs0WbQ7A9FCGAPC9U=
X-Received: by 2002:a05:7301:782:b0:376:bb3d:5af4 with SMTP id
 5a478bee46e88-37965f9ca89mr10030261eec.10.1794864018883; 
 Mon, 16 Nov 2026 13:20:18 -0800 (PST)
X-Received: by 2002:a05:7301:782:b0:376:bb3d:5af4 with SMTP id
 5a478bee46e88-37965f9ca89mr10030235eec.10.1794864018338; 
 Mon, 16 Nov 2026 13:20:18 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d07b3sm35450830eec.22.2026.11.16.13.20.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:20:17 -0800 (PST)
Message-ID: <0289a175-a067-4378-928c-359ba8126801@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:20:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/48] hw/loongarch: rename the 'virt' machine to
 'loongarch-virt'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-26-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-26-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfXz2asE9uHJruJ
 V4HCecwUk8Bd31AVi1QUNy132KhC4fAeuwS3vnSHXXiKMmBcpJtf+zTHVNuLurAkjHV74juqE3k
 Qtjir5vDkilEXSF6Jb2kpEG6LGvPVB8=
X-Proofpoint-ORIG-GUID: nz9J9XnFRITn6GN536L_gFAmKrZ8W-Ch
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX+c84tH86wDzN
 jb6u8lqzQLl64N+zKiEfyivnjgZCwdMH8lYsq/XKYspLPqUFpB4NFTNgdByje6iaf+bkR8DQAZ0
 ij6GlDRccUhCbK+n6Dtc63QsLJTp6HcTdea4n7LlFqNUle7oDJDbkvM7srNJdaNa/xOU2kA6POH
 67hA+c6Lx1u+mWdk/E+m+jPq5y/G0bRU8Ae1bFZ/0zWHOPigS3UWF9qTYL4Ex2NC8VgNe2qu5Y1
 LTw2+9if7d5W5u+h3TuUdV/5mZCGAlF1eXjaVi7m18nFa97D4F2YJPinDg1amGF35tyHQbEWGC0
 zl7mEnWb2b8usjiymJ8RrugjcEx2y4Wxa19PzRpc9WU2rZBOxzXRLTv+0qEYn64v84YsxsAoP/c
 rlLFLvAqXrt0Idkis4S6yQ84/z+tQZ9OEggSHljy3F8wGxmjcrH2PgFTer803K/C0oZZ2EA+2YW
 E7FdWgOadA5lsx23Svw==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afb7393 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=vX_OHtA2jq_LGBKDobQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: nz9J9XnFRITn6GN536L_gFAmKrZ8W-Ch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> This introduces a globally unique QOM typename 'loongarch-virt' for
> the virt machine type.
> 
> An alias is added to resolve existing convenience name 'virt'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/loongarch/virt.c         | 17 +++++++++++++++--
>  include/hw/loongarch/virt.h |  2 +-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

