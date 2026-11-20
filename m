Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6846606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JyQed9QH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NA2JgXlC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUFhW-0007v8-Rt; Thu, 19 Nov 2026 22:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhV-0007u8-3k
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:13 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhT-0000mW-Db
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:12 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK3UoYE1467015
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Su03ya9Lfho8svRwouqs/BAsQYytzXEcPSK8RYs5QnE=; b=JyQed9QHdUwh1/cc
 8kwRXQ1kTZRkDaZKt9Oe2Nosk9YRaSssEffdtigNFx1DeM1VY947Yas+O+eRL052
 xy17wLXBc8U9DOLVDTtboJwE04VVyTsQ4DWAgMqNYAbaLdkZWznYR6WfKBYrZAiL
 rPL58BsJSM/5276KRmpFcFsYI1dKhhd5zYgEt2DMBITJzrkAtvH5fayfLtLupsCO
 TzfpqDj8Gv2tNlkilddCZhrUuWouOeLSsPc17aRaF3KatxH+tedxe7p+B9PC57Z2
 rj3L5kRHtry/Oyx9GWU2Ac3H+KshkPMs+Ygiu8fK1FH3xxTwr9CvyarMxeJx5rLG
 ELcIRw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xymmcuh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3854627c1c8so576023eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 19:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795146849; x=1795751649; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Su03ya9Lfho8svRwouqs/BAsQYytzXEcPSK8RYs5QnE=;
 b=NA2JgXlCjjDSKzfrQ3ALA0+Jw5stSNukanXg/juLGqUcSJqA+Ws7HN8Q6BhpK+bBkb
 ktLACpUkHdung2ymkkqR8/x3M2Yg+oCmq6PcVXn2X6xGN86UNpfCF8Xswkv602+PUL00
 RTNtnhPNBGPiZbKCQT1gCdjXQHMGIdKw/N5F2h8VmuS0zfuZ+/bYNOzO+KvAshVAD++P
 /4x65qTKM0H8NYTNTm+EeaBIQNquA4JL9JkOQpLSgR/FtRSAOmrjpm9t7HdRafTvhUIN
 WS0JKKopo2tMcDLOEx4Do0v59qlTnn7+AGIU4KIw9j6tf8Aoj5/KwWhV0bY5YsiT7cgD
 Op5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795146849; x=1795751649;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Su03ya9Lfho8svRwouqs/BAsQYytzXEcPSK8RYs5QnE=;
 b=I9llIEp0fLF9/sXrUQGZJBZfZMIB7iphny0PT28bU9TmM/pSA/5Zfm5m3a4K0OcBNZ
 Rgq0zOm/leEt/RVzGQLtu7JqjXgSX1Nk6FLCu4TAljVLYcj0AY2QfW0g2t1TVm9UTCvj
 sdX2cS/0LOH5oItUoX/H4qyDFTOM9j1CcLxc7YMuC1dsovn0a19L5EB6eAb4BxsrKsWV
 KPHEvnEQU/zZH9+sGx3ogaJDtCCL34V3rflAsik+XVi7Dzy1xNxTJaEJaqKej8NusQId
 gbIL72tiqbigA9ONabBlJs3iOLSj67xHwB9lSlR6VfZr/csLJR5g5ju1Z1RSQFvvnKiG
 YgUQ==
X-Gm-Message-State: APuU4Z9i21/ToWaVG7c7uPMZP79GgN4k+u1y2P299JEVRjG6j1R9xmMI
 J9Pn1Gtt7euBAd//FwMigeMOuHJsIScwcxO1B1vTV7h/TwAenM6EQ2wwol8fDLqKQmv7+dzmITA
 7giSy5EKIfxslb6gS+1khAYyXNyBgA6NQfeK9b3YNH5O3u+HwSHYLCJ+q8UZNQFtosg==
X-Gm-Gg: AZFdTZeHF/pEnTdRx+zVEZAiaBBLjwTaxvjqX6NzHDCIXINhgsU3QKgN+iUJv3dD6di
 /DeW1ImaZiM+J6Uh3uRx5+GnjS3cI3CTNjb4rH5o7jHCqEyF0vhw7RNauGs2LGCcFjGbX5rWCHp
 Jn5wPyEA4GffyI5OPWflY7IxsDDo7x4Iptn02TFVpHggAZXV+7Z02msP3roheeXjazNhfPm4J6+
 Pa+T0qKukpex9CMUZd6exe6DzmJSTi6yT0ushlo7f+OdCV1wrr/Gls9Vrb+w+kT4+ZAD/JJvkqQ
 oz5YN34pQJIlJmsdd+MxmGlgjIatIWxB0fYn66j1YRm39Qk46wa0N/89QMHHUffYBL8sIohAl12
 R/bQF4q1KXtVCEYs2zmy45rwJow1OTiidUtRRopUW6d7b/cNY+Hc6v0Z5McUfRXkexLzGLt5bTY
 GqjjM9POVprOG7EXdX7EUv
X-Received: by 2002:a05:7300:d083:b0:380:f112:3cc9 with SMTP id
 5a478bee46e88-3857093f06cmr1526536eec.38.1795146849413; 
 Thu, 19 Nov 2026 19:54:09 -0800 (PST)
X-Received: by 2002:a05:7300:d083:b0:380:f112:3cc9 with SMTP id
 5a478bee46e88-3857093f06cmr1526510eec.38.1795146848769; 
 Thu, 19 Nov 2026 19:54:08 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm3854126eec.4.2026.11.19.19.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:54:07 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Anton Johansson <anjo@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL 7/8] linux-user/hexagon: Reset hlx_ctx pointer on cpu clone
Date: Thu, 19 Nov 2026 19:53:52 -0800
Message-Id: <20261120035353.3215703-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
References: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX2XwnfzpyZ7s3
 bRwPqd1HqteIjCPdmK4D3y51qSlJlDtxsUJ2WyqQmj+xU0tUOf3d3Hgk2JKqgqIrtwsgyrWL1w2
 kvP9ChxT3lRsa1j4NyuQrJQf323EG+E=
X-Proofpoint-GUID: WJdgo28yo2i6ZKczg0u_8-cBdkJpBvVg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX3PuAqdw2JW1v
 SWmr1tSJW8Ox3GS27hBpPlOKbKukI1O0UQ8i20/fXeJ6L/jHfz1j7ixj+wEozODOwuJodJkGlij
 1iaOeJIb/6Gmc6nQ4CO5U2f/a7tRAfEAshz/n3ome633jPy9rCoj2gJACarYoVTrWLpZUekn5Mb
 xOJMAmsX9kPfr9fCfvcbqKwJXIbD7VYj43kTAGFzKEulbL9N6DIGpJalE3QzKYoowC03VzgQig7
 +UNE7RQ1saZeLYVo4WQiKMKxiTfg6Aii0V9mlZa2DhILcL2zfUWFToH6HHhSUSyL+nZYh6YrPWR
 8V8wTNp6wbnIqtKQzm7Y5iWbNzIcUa0i0dw4TeXjijR1TqfFfY2PZaQtADt5WdjWcw1zHgftGM1
 15w1vkJrl/qWKeLbKF+a9KxHGKPGPhFvJ0ArOpgynpIot1yY5Fl915en1bqx3sPAqm50NoJf+LE
 7kOU6PTAcSJZX/ewbFA==
X-Proofpoint-ORIG-GUID: WJdgo28yo2i6ZKczg0u_8-cBdkJpBvVg
X-Authority-Analysis: v=2.4 cv=WKPqzXsR c=1 sm=1 tr=0 ts=6affc462 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=x7G12wM3ofS2vDNBxVUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200015
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KCkN1cnJlbnRseSBobHhfY3R4IHJl
dGFpbnMgdGhlIHBvaW50ZXIgdG8gdGhlIGhseF91c2VyX2N0eCBvZiBpdHMgcGFyZW50LgpBbm90
aGVyIHdheSB0byBnbyBpcyBzaW1pbGFyIHRvIGh2eF9jdHgsIHdoaWNoIGluIHVzZXItbW9kZSwg
aXMganVzdCB0aGUKc3RydWN0IGl0c2VsZiByYXRoZXIgdGhhbiBhIHBvaW50ZXIgdG8gdGhlIHN0
cnVjdC4KCkZpeGVzOiBjZjBiZmJjMzM4ZWFlZWYyYiAoInRhcmdldC9oZXhhZ29uOiBtYW5hZ2Ug
SExYIGNvbnRleHRzIHRocm91Z2ggQ0NSIikKU2lnbmVkLW9mZi1ieTogQW50b24gSm9oYW5zc29u
IDxhbmpvQHJldi5uZz4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9z
cy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5x
dWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiBsaW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2NwdS5oIHwgMSArCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hl
eGFnb24vdGFyZ2V0X2NwdS5oIGIvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9jcHUuaAppbmRl
eCBlY2I3NmU5MjY4ZS4uNmMzNmI3MTY2ZmIgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdv
bi90YXJnZXRfY3B1LmgKKysrIGIvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9jcHUuaApAQCAt
MjUsNiArMjUsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY3B1X2Nsb25lX3JlZ3NfY2hpbGQoQ1BV
SGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgIGVudi0+Z3ByW0hFWF9SRUdfU1BdID0gbmV3c3A7
CiAgICAgfQogICAgIGVudi0+Z3ByWzBdID0gMDsKKyAgICBlbnYtPmhseF9jdHggPSAmZW52LT5o
bHhfdXNlcl9jdHg7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVfY2xvbmVfcmVnc19wYXJl
bnQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVuc2lnbmVkIGZsYWdzKQotLSAKMi4zNC4xCgo=

