Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510FFC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x419X-0004Cj-Sm; Tue, 08 Sep 2026 15:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x419W-00047r-9d
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:06:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x419T-0007Ro-Tl
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:06:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688FdXou3429802
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 19:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=oWeWgOb0W2kUjupQrpCNio
 vRoW7q+lX5VBtb2xwzk04=; b=X3DHkyuLz51zUfyrTO0CmNbxNB31buBCN98q46
 e1LvUUNGSjaauj6NHLVlh7+q34PgqeIeZiizSDD2R28ESVO8bXmCx1miu4JittlA
 E5riCVTvHfaC7JBVVFnAmEHZZ/Yc0298V2oFfs/BSrVPG35R7KQUZ+9oWWVjoUlS
 xpAJxCzBSirF46CBcGhIR9b/JAILR0XDv0RQvzO1dEXNypjyAJ/E5sLdZDbL8miT
 XURLkTSXKPWzSBS6VnnLJ+bTjbZMulqxAsH/2x/+TMbsVFHi/+p0wNan3fEbtloT
 n1oBaEWW0VC2ygVYIes0+WhoAOQbYu4ajCzcPi5oz11NjtGg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjhkj2677-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 19:06:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-396638f9a18so3730539a91.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 12:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788894392; x=1789499192; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oWeWgOb0W2kUjupQrpCNiovRoW7q+lX5VBtb2xwzk04=;
 b=PT47o24Ri/nb6/aUwG1gPdY66xdebpOrtaniEwqN+ttI3RoahY9XaPvfENqopkCOd2
 q7sgAR8whNfrwQCFYLfzQHrw79S6LpfoOepHSLzKkJ1s9JVE5mieghXA16g2HrAQozJb
 +lzCV6+UTJAbDr/ote2lwVE5guCT1UYnaD2Yt5HLpbkSIAZIN38RTffqAq7ReXF28oOI
 MbhfCNe8kBDLSiRwvhrOa7WRclSTUvhKVcroS7PUZDCI2u6ibeSNxAUlDePnlHu+MtIw
 CPKJALOXWeSY3e/Mp+4T0AnQgSCOds9S2pKOyaiz1q0IWN/9rtwn2yIL57BTILeBl9fu
 j+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788894392; x=1789499192;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oWeWgOb0W2kUjupQrpCNiovRoW7q+lX5VBtb2xwzk04=;
 b=Yn7GysY2mJ6yyIe1vzOE42R2uksqjq7O3EbzSYNqPp2M2RBBbaOazRQq9vkNzuKvBG
 T/gOcHbUz2IBSNxaCqPpFnVNVQgENzSAjG6Rn1N+cECbUI7TsiReRfoPwKWfAYPo0IX1
 BdFLFFsBdo+q+eKaKU4mubt5nXyza+1Sesl2zaEKiSzmgQhewfs8I6FjKRjc7lgTzIYX
 IvwbE36POXMJ7E/MCcLw8m/pWP/gJb6UewZadw1Yloed1fl5Pw2GFwXvLTtz2oyh9teE
 VTl+qnRgbJUmnOKRBeCXe0XSiuiPSkmu9HDyGjK4kCUMimwnrmmrAq9jDyvxklkkFieU
 J3GQ==
X-Gm-Message-State: AFuF++k4/xhr2X+BBvejGG+4TksdACIWPGj2WO+0DMZMoDl0UyKS1Z7P
 XXK1XW3CBb2sF9GJ4ErGA0zIOHf5Uhc/zINda/tB6+t8IRYqm4oKkLIgXsJ6nWvJTJ3+v+ShpPl
 0hJZ/Ae5UOg7P3OOLQY2NxtTEeKJfjCfOtO8PK7cJp7CVTDi1K70k7ej5H81NZ69ggA==
X-Gm-Gg: AYBFou0BvQpAnsRQvdtciWlFMlBq/Qp02SecdZtrdSfzMz5Pc8xGOuv1Re9fdQDQo/q
 MGbq1vnQRPKRe+d8TNQ/HMc/k8nCW4aWDw/JHr5PO6fq39DYM+nlcRywjida+kKve8PK3RPmZJA
 K6Mcdt9yzN9Tolw4AsNv+XI38ZKk+K7P2LD8h+aa44DZUj5D1Rcn7h5sai3k4+LlNNbCpVsokK9
 /YuVHep7HPGqbvccMZOgBlIOZ++mBoxHVf23wXWOnDloVOK0ObMAzpU/5zLGftuhMJzUoxXYd3W
 lVpAHjc/gVP2EsHixfnNGusLNx1Gadr5rZqE7ZyNp4FBXWbbZekPCjlzh7AfpTLdJH21mu9wd9E
 u88fF/xgZDhTb0ad4vMeaKvMxD9BA126IW3lSZgt1bpVLPiSy
X-Received: by 2002:a17:90b:3fd0:b0:398:d6e6:4671 with SMTP id
 98e67ed59e1d1-39b262981a2mr44193927a91.25.1788894391688; 
 Tue, 08 Sep 2026 12:06:31 -0700 (PDT)
X-Received: by 2002:a17:90b:3fd0:b0:398:d6e6:4671 with SMTP id
 98e67ed59e1d1-39b262981a2mr44193864a91.25.1788894391226; 
 Tue, 08 Sep 2026 12:06:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432435ec2bsm33304142c88.3.2026.09.08.12.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 12:06:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] docs: Correct semihost spec URL
Date: Tue,  8 Sep 2026 12:06:28 -0700
Message-Id: <20260908190628.2767509-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIwOCBTYWx0ZWRfX2XkJ1x+miy9Y
 ivl2NbMH6qor92dF08Ma2UCkpbngQ/V4azznBIcRrvi/o+OOd+ojga1t9xnojJDEREHYjdMKDEs
 vKsk6XqbnIam2/ZdyDX09lv6vr5aBOg=
X-Proofpoint-GUID: wkUZW498iRoiSC2l2TQUeLmXLnkWfWxY
X-Authority-Analysis: v=2.4 cv=VYjH+lp9 c=1 sm=1 tr=0 ts=6aa05cb8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=tSODnN1-WjF6-noYxS8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: wkUZW498iRoiSC2l2TQUeLmXLnkWfWxY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIwOCBTYWx0ZWRfX3dIps6YCHy6v
 cH/gUEarqJlgbHRPsAh+x/F2nmEIcjHZ24rtf7yeSW3Kpel0YCFpN3fqXnx+Ug3F9/5n3aek+nk
 tJ0T/HY963HMUWSCDMTrkDRuGwS7ZrEoomVCkDDUpI/yTWRhV0MXGswV26vllGgE+CJkHfd+get
 jIhG5QKNFv6YulNsclSQikajQ6t6K8GEGscoK/maZJArdTlfZA9+cUQJgH/5tssUToaYrlcHsHa
 ezZDXxzsODyRT/A5APpJuuofC2dUSCZfnZ3cxH+w4oGo819GLLxQ36TNJ+M2NrUj9FwS5vjDKCZ
 MpSbeIxTRVx9745ZF1rUfBzFg8PuZZkHuaigWAavlHKPen8U+GISvKgv/GBn37dSWLutqBsK6QW
 KAobCiUt7usZcoju8aAESFdoa2wP0liVCpuELKgMTczYV41DIci/fKIlPS0h/vmcH6Anoqi+wpX
 x89pqPDsBTLHM3SG9lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080208
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

VGhlIHByZXZpb3VzIFVSTCB3b3JrZWQgYXQgdGhlIHRpbWUgb2Ygc3VibWlzc2lvbiBidXQgaXQg
YXBwZWFycyB0aGF0IGl0CndhcyBub3QgYSBwb3J0YWJsZSwgZHVyYWJsZSByZWZlcmVuY2UuCgpU
aGlzIG9uZSBzaG91bGQgd29yayBiZXR0ZXIuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFn
b24ucnN0IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0IGIvZG9jcy9z
eXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CmluZGV4IGE5ZjhjMjk4MTBlLi41ZDQ4Y2Y0MDFhZCAx
MDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CisrKyBiL2RvY3Mvc3lz
dGVtL3RhcmdldC1oZXhhZ29uLnJzdApAQCAtOTMsNyArOTMsNyBAQCBIZXhhZ29uIHN1cHBvcnRz
IGEgc2VtaWhvc3RpbmcgaW50ZXJmYWNlIHNpbWlsYXIgdG8gb3RoZXIgYXJjaGl0ZWN0dXJlcycu
CiBUaGUgYGB0cmFwMGBgIGluc3RydWN0aW9uIGNhbiBhY3RpdmF0ZSB0aGVzZSBzZW1paG9zdGlu
ZyBjYWxscyBzbyB0aGF0IHRoZQogZ3Vlc3Qgc29mdHdhcmUgY2FuIGFjY2VzcyB0aGUgaG9zdCBj
b25zb2xlIGFuZCBmaWxlc3lzdGVtLiBSZWFkIHRoZQogYEhleGFnb24gU2VtaWhvc3RpbmcgU3Bl
Y2lmaWNhdGlvbgotPGh0dHBzOi8vZG9jcy5xdWFsY29tbS5jb20vZG9jLzgwLU4yMDQwLTEwMV8x
MDI2NDgvdG9waWMvc2VtaWhvc3Rpbmctc3BlY2lmaWNhdGlvbi5odG1sPmBfXworPGh0dHBzOi8v
ZG9jcy5xdWFsY29tbS5jb20vZG9jLzgwLU4yMDQwLTEwMS8+YF9fCiBmb3IgZGV0YWlscy4gU2Vt
aWhvc3RpbmcgaXMgZW5hYmxlZCBieSBkZWZhdWx0IG9uIGhleGFnb24tc2ltLWNvbXBhdGlibGUK
IG1hY2hpbmVzLiBUaGlzIGNhbiBiZSBmdXJ0aGVyIGNvbmZpZ3VyZWQgdGhyb3VnaCBgYC1zZW1p
aG9zdGluZy1jb25maWdgYC4KIAotLSAKMi4zNC4xCgo=

