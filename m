Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD34EDEBF5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 21:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWwU-0001ew-BU; Tue, 03 Mar 2026 16:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxWwR-0001eY-VD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:06:08 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxWwP-0006Xa-Hx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:06:07 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623H0VWL3548601
 for <qemu-devel@nongnu.org>; Tue, 3 Mar 2026 21:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=WGNTkSjXwDo0UqEQO159IQ
 l9KIx5P4OyAEFu9CCbh1A=; b=FMNa89G8ZniTK0WVeHEswZCDaRRr8AfhrI4IwF
 wELKSB53v1Hlb5r+G4pk4AWlOw7U37NcQDoRHWJycqinVnkDSqCDyE4r+zJRPVkx
 YT0bgDJcRCqobvKI4LQKNwHGz6VLYC4zCSQvRAAyU08UiYrKVkLLLRzw/cDSaYgP
 efv0gDHaxNPeUFtTkva3HQJFgA3Ct88rTGMlpjOpkxJr+SMRxnXD0sh7xWNaqrOH
 VzuTt7Fi4c0Vvrsu6PQ4WBkbqcgOR/kcY1UEnmoXACYOHNp+FDUzzwiw8g9pmRNb
 lctKdH23RHKHD9guGfnuIAzIK8CBBHyBjKP3aUjFgLeksYUQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvxfaae9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 21:06:03 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-464a2e39173so63108561b6e.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 13:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772571963; x=1773176763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WGNTkSjXwDo0UqEQO159IQl9KIx5P4OyAEFu9CCbh1A=;
 b=Tz0XS8ezxJ4gki1yN4Bi9o0x6OJexrJXQ4jGTQ0Hl+GLYo32HpOkK10kei5d7AbyV7
 xlS/ai6g0AJdHXtJeF4xUhqgaj7Df646/AjAmf9/EzWXDdmIGTvHyFZJu6IocQRaQBrY
 aJMQ5VLIWjvCAoucOIHk+PLGfd+dIBtvxTqrWi6fzI0GvEusDI2jdpnkoCNHTKwmRuGS
 3B9HmFEAj6Gegoenh/KkqglqexsLx1i1fl6uv6FnyKOCT50Rke3CZQaPW3xCkaVVMr0C
 83rSUm8SZE3kNODIm20g9q1vN10jWo+yJXQoXEEayu2SljthLhcAqAbDEJAl04nv2QSr
 Tl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772571963; x=1773176763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGNTkSjXwDo0UqEQO159IQl9KIx5P4OyAEFu9CCbh1A=;
 b=Hp2oHdCvxdQJ0naolH1f6MSlZ13deiLi8ibXO/AqQJ8CpNBZiulW7m2rbYhSTxH5o2
 mitlsB1pc3spDWUZjdeZNlz3bg2yXY2zmP2goToDBzRMMPfTGN4nsjj2qV/sPiA5jYWR
 CLwD61o9wZwNzUcN0E5a9e7oMo/Zi3z0jD8y9rlgFmMfaJExEF/GrUhqrv4XsTMMcnVm
 LkUxM/F+Ovm1a7HXys/t2se+tOGuCV7On4wU5yab8edLCWJa1ZQjgLaLbCYtTcn6sicY
 Sp/0vuj8B5s+t/F0WV9ToWA+TYMAsW5lxdepQYJp0NuhslOomAroPo88ADpXpJlGYpK8
 iOWw==
X-Gm-Message-State: AOJu0YyJQhGVkRd6JcjCiziE6TkreT2HbO+pBW5TK3cvH72vkaJ47qcU
 ajPI+XfK+a2BZJ+UWQ5IQ7TqiHwS+uI2QGBLD1zroF5hNW0ViRefkKUCxaPHnRD2n8gE1Jf+SyA
 MOTUVUWn1iivFVl7nh5XsuemUe3X2R8YEUPOiBh2lL5oWk4vfGkLWNC4X3Cs91M3IVw==
X-Gm-Gg: ATEYQzzYvzt/0lWXFxkyV9eQbTN7CyPU54mEhLfE1LTc95PtoOF/sN+H3nVU535t2+C
 Q2WeFE7nMhqxWms/16WwtW+o1S2prg7Znm3jQFXZf6GEdEJ3VsYkqbyny7iWA4EtUUCfdqTulM0
 WhQoNiku5mFXTnPXFUJwauiDjLvlbT73BGpbSvA5Aknwx5G6dXXxavn1LAe2/3brfkajwXwFABQ
 n2KF6EbeN+3YE7ecjuKmaLtIhl9VsxlD9lnGNXBM7sdAun2Bhe3ycicWV6MrfUgQl8k2Bx3K4G+
 R56WmP62Ensvz6MwEg5wRJhDdgaXTEsxIzimCs/BiZj/OTRW+aK2PkN+ABjrG8AMgkgjp42gcrD
 r+h7RtYrNq1UeT9DPtTyEge23+0++AIZlLckG48MmTGBEjZht/H3omYxvo1uQhs2ZgH9zOQ==
X-Received: by 2002:a05:6808:c3ef:b0:464:3557:a73 with SMTP id
 5614622812f47-464bea413e6mr9939713b6e.11.1772571963189; 
 Tue, 03 Mar 2026 13:06:03 -0800 (PST)
X-Received: by 2002:a05:6808:c3ef:b0:464:3557:a73 with SMTP id
 5614622812f47-464bea413e6mr9939689b6e.11.1772571962783; 
 Tue, 03 Mar 2026 13:06:02 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb3ab494sm9998617b6e.8.2026.03.03.13.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 13:06:02 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, berrange@redhat.com, alex.bennee@linaro.org
Subject: [PATCH v3 0/1] Update hexagon cross container to 22.1.0
Date: Tue,  3 Mar 2026 13:05:52 -0800
Message-Id: <20260303210553.2044313-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MyBTYWx0ZWRfX6w23qJ0v7l2v
 sSnQTub1JbVOIxJ1pGKIaYy999TTmYe3T6RvqI6bWcMhsqeEyJTzLdxAvqXaC1aqIWgFQxLmcrm
 wFfTsK6AYJP18LHXSoErAs96fyvV1Q6PCxQ3rv2w9GP2VTGGpb7fu4VraAddvnGgMmtfBqg9ROp
 I+C5h9n6g5LXy7qVmUaPye64b9gBf0+4acV5wcFdsaSoYZyVl1/wAi0rjoqe5sOW61ZcBMJVKe+
 KrkPhrYaevAViZ2kwsXMe8y67XY3ru9toZhZQmdzWqIulF67VXWLqLyG4s17EhgP0CgLjXFTsLR
 SYulKf77Z26ppFErbbC3nHOmfX0b1/EqIaRnSdf+dWzoNWxM+9+2iTbgUvBdhgkZZAk/Y9VtspT
 A2X5tRCsQ9xbgLMnUdgBSvz3m+cN8Y58p9SQlTSyz0WhpxUTE8CSMzrGxBX5ULLFJg7O2T4sq22
 D16IWsg0TFWV4lmOcHQ==
X-Proofpoint-ORIG-GUID: DDuWQbVelr6ROxgZUPuerEkTc4nB4seR
X-Authority-Analysis: v=2.4 cv=S+HUAYsP c=1 sm=1 tr=0 ts=69a74d3b cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lnps_zuvmrPqk_99VuYA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: DDuWQbVelr6ROxgZUPuerEkTc4nB4seR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030173
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

*** Note *** that this patch should not land without
"tests/tcg/multiarch/linux-test: use portable alternative for dirent64",
a newer musl present in this toolchain exposes this test issue.

Changes in v3:
 * change debian from 12->13

Changes in v2:
* none -> v2 was unintentionally chosen for the first rev of
this patch.  :(

v2: https://lore.kernel.org/qemu-devel/20260303175444.1540049-1-brian.cain@oss.qualcomm.com/
v1: <none>

Brian Cain (1):
  tests/docker: Update hexagon cross toolchain to 22.1.0

 .../dockerfiles/debian-hexagon-cross.docker   | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.34.1


