Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564E606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UQXmlZtF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MpFFl+gH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHsw-0005uu-RK; Mon, 09 Nov 2026 00:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHss-0005uk-45
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:25:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHsq-0005sG-ID
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:25:33 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93KNlj2746300
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 05:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t4HLjBMRLCOQZ0GcF2UhjAUo/wq8b9RC8V23SM6fsEk=; b=UQXmlZtFLsHIblUr
 fAdAH1/paXL8crYG0q/pQaXwgeuSnjyHdo+Wil+c4fPVIKG95vSmZ/EP0/qoUa7C
 l1WoR8gw4amRSgrcO7MpgsihQGEgdr7xo+a2N2p8TI9FKSLD0zPTLAv39j29uVFh
 gzMol+6vM5fcyXFicjpr1WoegLdNNr2PjMLu4vEdJYWKoGDXRPYVJtDmyGiCIh+a
 eJ7ivBwMV6Y2FChJEuB9lmJ62bxrILZMNJTt2MhXIRV1HGcEquByDK1Vj/HOlbnT
 Js+VVrJJUU73L49FpbCSnzcZyXP3oUb1nPpyzxYnuhspz2I8N03MX/xvBFGRQt/j
 7Exq2w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvrevne1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:25:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so1405667eec.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 21:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794201930; x=1794806730; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t4HLjBMRLCOQZ0GcF2UhjAUo/wq8b9RC8V23SM6fsEk=;
 b=MpFFl+gHSywYzj6+8dA2DCsXwyP4PCiP8Q6+h4lelmdR9XHD02bgWkDz1+AIGFay5F
 VO1YDfcp/PO4cyjGRmwdSw/UZmvjcPqIs8Mth2Meiar3WZpihwIJGtzdu5lYI5XqPijz
 jHOeaeEqfZLf/utjrMXUDIM5y0zo5wSwmLTNHP6kqQ6o6g4uXU6/AZh2MOEdtaT8a8r4
 ll2XNjn0HjHkUv7MPraUSlfbjzgcz+vL5hQbnDq3xhh8HQz7lgRwKjlDxCNin4LJRO0G
 aWEWUlkYpnePaiJXg5t3OezN/9A5kxxfkRgpy7QrR1aBH5Q4OR3HUjW+0TcLeZf9MVYz
 NjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794201930; x=1794806730;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t4HLjBMRLCOQZ0GcF2UhjAUo/wq8b9RC8V23SM6fsEk=;
 b=lUqR5pitX0ChD//8W0FP3L7JtRi8nsWLgq1jQF1sCMURK77Lzm/Tq8fwunruWqsGaD
 WLFoRHIhgx/7uzN0AqhtMB/sQn3++2zIcj/HSXoAWQyo+BrWkZYaYYICnkJln9Nv86oq
 EIQowiD26HrO1Ra5YvXhO/A+tJaupR73dchvYbctTTu85N6ReOMbgfIoXsyKahQZKV1X
 f7D56HEfDrbCpkHbuvMKZbe/hsN82I/jIGPvX2cHB3EiI7TqmYsJTyDyk+uKsxGxD/nb
 IcKJs6P4C2hpVL3IzLiVoPtwlHv4+wOwpu7p0DvmjzjuOftRIQjka7F7iwCsZHOJlu9p
 v5Mg==
X-Forwarded-Encrypted: i=1;
 AL+hErEy5sktV+iE1wD/dyZfkGwXeZJUmoVUMtlNj/1XbYHcNu2oqdRmYIEIyvh2TJtv9IW5FUiRmT55y2cf@nongnu.org
X-Gm-Message-State: APuU4Z+eLlDBpR+JSTv+igx6x9MvCZ7XzpwcJ8CJ+WbnNXZjQMd1LCCC
 +q+63WyTA5esu14GejvlkNhS2r4byDLF7VF4LNyuBb9aQuUb0DGJs5fifjSSPrzl5X+Dl/cM0mQ
 BK0eXqdPuEk0MD+MNFVKdfNeia4BjGgazRyWGD/jVNB/gBNiv5Ham95t5SyT8tU3HxQ==
X-Gm-Gg: AYBFou1nFWQRIjTlVwUwImRvux+vt6tvtVsZvBUBrD9KZZAg4o8syWr8ksnyLzVta9U
 ByH6OFaqNSqiiuMww/qgZeR6Df8vTwOJ0Gcp2xRYyfZS5SpGnmZOi1ItHGD36VbAeVtbp9vlgCq
 PvSGvyAdDzWPx2LsJbSYZ5V0GTnuuFYiUhxdkgdwVlwB55IfopeACtciI+WWt8IGFojaCE/KsgQ
 TJQWCMVrTIVnxp561V8WgDfqUNxYsayz5EC0pySOFqj8iqhP2upUphPNLlazxWoCgeHZieU61Aa
 2Yhe2G9jQiv2qXORLsfdMLwnURNgGvSwXMXhywVvaQk+DvR2bBOL2tIPTI2yKINmVHrKdp6A45J
 iu5NoNOflNIL2JN7rmKogx15SleHNdoQ8Ovp+EGtH37nSs1nU0jR/OXF2nSN2U3VKTpgZUUyD6i
 REqkaKfFxC9d3bmW/Qyn7+9WYDU0uRXurpwtXj9DJSVw==
X-Received: by 2002:a05:7300:7f19:b0:35e:da0a:75b0 with SMTP id
 5a478bee46e88-372570dad9bmr6465454eec.25.1794201930031; 
 Sun, 08 Nov 2026 21:25:30 -0800 (PST)
X-Received: by 2002:a05:7300:7f19:b0:35e:da0a:75b0 with SMTP id
 5a478bee46e88-372570dad9bmr6465426eec.25.1794201929515; 
 Sun, 08 Nov 2026 21:25:29 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372667d60absm10569669eec.26.2026.11.08.21.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 21:25:29 -0800 (PST)
Message-ID: <2ac4d834-ccf2-43d0-bcaa-0593b846a6fb@oss.qualcomm.com>
Date: Sun, 8 Nov 2026 21:25:28 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] docs/system/hexagon: update the overview and
 emulation limits
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
 <20261109042307.1301438-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261109042307.1301438-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyMSBTYWx0ZWRfX9FMVAPQoXUyr
 yCshek7+TR68fBs5C0MKjNG29f7EjeR5JmfN9Ri5FhKCT5zNyNTO7LmFCXjr0hloXe69YwTojjI
 j9olPp0YDqH+qxykgRyz3FtGjy0AEO8=
X-Proofpoint-GUID: o73f_v1rCpGdv3begy4kYglAo2E-_kKa
X-Authority-Analysis: v=2.4 cv=FrKQbGrq c=1 sm=1 tr=0 ts=6af1594a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=SS4hb3LsxyRXZr2XFXcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: o73f_v1rCpGdv3begy4kYglAo2E-_kKa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyMSBTYWx0ZWRfX7gqwI+Jie6xD
 iyK8xTJBI0jXVkvpiItOV0GNXCy81yNTCpKhcmbJlaj6WE+1GjeqvUk4Brlnd2Ggr14N6GAcnDO
 2J0fBYKXwXFM3Lqd8Wmf+pQwLKah3A62YBf2eFqDHOMq24AHW/R1yHHU/VwZIbGqTCOcwssjjsI
 mAYYXxSWTahtDP0urPF6h4tlxxfVL5CZo/r7atl2mb/PLBwVMHzXYRGql1JnPeRWDiFQVvczp1G
 83qho0+M0LYx4uSXW85WRZX28myF7zmZ+DdR18fTUd+3GOeFVh9TH20nU+t9oIUjJ1m6lC+N9Wk
 QJcbXi+355LUXx5erinuBMOEgvbdVRo9n3AAmSDqjaohA3U3rHYvIKCTUx5j05qm4y8nTGYWQfa
 F9Qp3VjAn9pOHfxZJ7Hem0BNzRfuu4nVVR70+tVjvcrR1sX3viN1PqCUtQLr7SkCRQcpRD2C3wy
 P3dekwDL+qHWykYXonA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090021
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

On 11/8/2026 8:23 PM, Brian Cain wrote:
> Describe the devices that the machines instantiate, ELF boot
> path.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/emulation.rst | 18 +++++++++++++++
>  docs/system/target-hexagon.rst    | 37 ++++++++++++++++++-------------
>  2 files changed, 39 insertions(+), 16 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

