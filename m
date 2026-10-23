Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA05606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C6MQU87Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g0GQepU/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4S0-0003PQ-NQ; Thu, 22 Oct 2026 21:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rl-0002BU-0Q
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Ri-0006PS-Md
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1FmI64008248
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R5loPM5CM4LywapUtjXF0PuYDvm5zN1zizL4wCcdXls=; b=C6MQU87ZU9tbRGyK
 FVINFbuy9AnZCl4c6GmWtwxrTnXkZPqx92SyqU+JutCd5J7mQ2vtQoA4QW11bb2f
 dmAiby8Jq/t0i9zSx4grRAnWiMmAsUNUrZCF0Nvl3JLL8DtMPDPrfxr4oSxlEu8o
 jTi9mJ4k+j7y8hLOphwyCQhb/IsReMjqCNL9Ed9Kxk6xeRCiu7Lb2jj3VaDtN+hL
 GVVhWm5Oho4fH88GvWyYS32mmkL8PlC9yH8Y4njuOsko0Y65YDCPo4OwiN1iDGU7
 kRMpfENhli2TLV9o5l+1oxRFuR8+7axGOAOqs5wkWCoLf/6Xv8X5i+6+rLVy0WSF
 yBCGjg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmarvch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so968256eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720297; x=1793325097; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R5loPM5CM4LywapUtjXF0PuYDvm5zN1zizL4wCcdXls=;
 b=g0GQepU/dfBz2AZv3WiZ+vPt6uaBBWQaAttX0ux09F52y2a3cnNmbsZwmLvSIOOD3S
 DZHBvZQ+hgi5kBNNoj2DhQWTQu+PUOIPHU1RpTq9P9QcdSrGWlmHjewdOdwA9AoZ2HoI
 4o3u5v6zS70aeIa2PRAsN99ZgZ1ioZxbVpts+BJmkxpMX+VcknL4U6YfxrxRDsZk2w9h
 zC+MITGNGF2D6FOkewN1mFUhhRhE/jyLxyHSOnRy1zcTYRFRmmz+z+EHNqnqlq57dd8z
 5XF+b7lAiseq7/dH0nzsITS4VVZ/5N/FLcH2q07GQal6fEvPfDjs91tmPqtuiuGUA58D
 HPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720297; x=1793325097;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R5loPM5CM4LywapUtjXF0PuYDvm5zN1zizL4wCcdXls=;
 b=EKCWcxrCgbWA9xAUJb3hLSkcQw6tNvr7eQOY8bMGdxrS635P/aBnDT7zb79pW0Ocns
 CCs1aCsyBbccehCg9DgOHQdJ74PpcwCHu785xylMDiSvSggJt+leoCDYIa2/Hw+LM3/S
 hpl0jstCbG8Nglt4kehbJjoSG8eDaGc1LlUAcPnnqegM/lbrcPyJOCR5aTN4gcGP+ZGs
 OgG/+ppxwo6ZH10nKIF5HAecxdrsdkWNz44J+6H1QF7SqqYXBTIG8XUlqWxHEzpM8IAa
 xECXASuozywEna/zePlqaOnbSp/Wx1tJL+exzPympMNJfj1mJn6RCDXGiCbGF9p8yaVi
 68cQ==
X-Gm-Message-State: AFq9FYIUk9oZOxAcZe2+XNmvYJuCFp8hrpstlFP7kwnAlggTDBCY/KnK
 3POLvpV46VNkyrZFfOOU9WdDq0pVsxUSwgc3wgdd6aw2q/duGNAB/vBXl3lhCz0pamntCv939ls
 wJx1I45tSmA4Npbja8W0LUq0b7A153ixhl8Q63AAmzJQ2iaIcNMhG+t4EJUYxrC14Yg==
X-Gm-Gg: AYBFou2jSTwoqO0CVoJOIHMnr94dZ9zkmaA8epca7XOXWIQL6Fj9WYTC+h+wqZAMNU1
 5+QOJNDVZnnWIE/kEL893SPiJ3llsuluT4dSq7ScWSmoUgLUT897vxPEd7+jCisuxizU2Y5oFo6
 5cSkkvQtBaJjmSbNXX7spls6ZWlH7SbgdrF+yaEFSl+jyHRVOTUuOgY1pkdFLSqByoNyi28H53t
 LRdhHanuM4MMpayGLGulllsdSl2MoWurdegS85fSLjaslxlbY0Vy6Jy+TVuml5lvIvsMu5hC/ig
 yjmt+NaQktcmzzOWbdImaIG8WTVcO1bbtHTBtbvpj2QtiPjqgNaUv2HGtArdn7PY31h3bdrw5WW
 gqM7Q9mJfNs8K13+r49hUbmA4xSzQLvbfqXDrmDHiOfMrpXB6
X-Received: by 2002:a05:7301:650b:b0:35e:5f8f:9665 with SMTP id
 5a478bee46e88-369d98a71bbmr1619475eec.29.1792720297409; 
 Thu, 22 Oct 2026 18:51:37 -0700 (PDT)
X-Received: by 2002:a05:7301:650b:b0:35e:5f8f:9665 with SMTP id
 5a478bee46e88-369d98a71bbmr1619442eec.29.1792720296860; 
 Thu, 22 Oct 2026 18:51:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 32/43] target/hexagon: check exception_index in has_work
Date: Thu, 22 Oct 2026 18:50:29 -0700
Message-Id: <20261023015040.2473105-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adabdaa cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2Qhxk_BCo_5fC3_CN1YA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX3blQelYseMJB
 sAEZNLo0mrmDdmCH6jQcegvtJ/TKYGPmOmaJIpTht9CUgtu+cJ9NdYb4IyX1eEm/CB8idVXo8Q8
 qMBw/mp2CawP22En6fLfGFn0ZYVt9tc=
X-Proofpoint-GUID: J_6sfoosqyFfU7U25ng8sLdzXaqCvx-m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXwvOCN959b4cH
 WyYEkTBySkCFyfCVunVaKXNwGkIbLZVrh5eooAkdtvUrJoV/OsmumBAlfHFzCkgmZPC+fW7iehk
 RPva3BHo9aIcpXIytp6PtvglA0BB4Ge040W5ov0OCqI5mkv59bpTci4t0vlG0nmeRyLLfQ9/ckG
 oKkFPN8S5GFYkbgPvVQNjFBrBiErGH7khFF4zL5e+Qu7pEg1csZ4dPwdd0d6GKG4su9SEPCXHbq
 boOmXE7R8MMUX7wHR50qR3KIfAwFg9TVIiBiUGrDJhXqMCr5O9MncJytJFOSYtYWsIkM6qg88Ns
 arNGXSpGXJGkiCiwgHoXPDZzA3UDc+ZsgJRXYl9KgMA72WXtg7BdW82r2jQ/YIGe5499JToAcvP
 DsPALIU6aM8SLhI3pMSO74yMQTKBR9p71dVk622c+a8PyhhglPUrqGiG/vkXOIyrdD7ewOXEXUt
 qwnbr/OZNHURqEJvLpg==
X-Proofpoint-ORIG-GUID: J_6sfoosqyFfU7U25ng8sLdzXaqCvx-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230007
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

V2l0aG91dCB0aGlzIGNoZWNrLCBhIGhhbHRlZCB0aHJlYWQgdGhhdCBnZXRzIGFuIE5NSSB3aGls
ZQppdHMgbW9kZWN0bCBFLWJpdCBpcyBzdGlsbCBzZXQgd29uJ3Qgd2FrZSBpZiBubyBpbnRlcnJ1
cHRfcmVxdWVzdCBiaXRzCmhhcHBlbiB0byBiZSBwZW5kaW5nLgoKUmV2aWV3ZWQtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdl
dC9oZXhhZ29uL2NwdS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5j
CmluZGV4IGQ0MDJmNTVjMjRhLi44MzI3ZWU0ZTRhNiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTM5Niw2ICszOTYsOSBAQCBz
dGF0aWMgYm9vbCBoZXhhZ29uX2NwdV9oYXNfd29yayhDUFVTdGF0ZSAqY3MpCiB7CiAgICAgQ1BV
SGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKIAorICAgIGlmIChxYXRvbWljX3JlYWQo
JmNzLT5leGNlcHRpb25faW5kZXgpICE9IEhFWF9FVkVOVF9OT05FKSB7CisgICAgICAgIHJldHVy
biB0cnVlOworICAgIH0KICAgICByZXR1cm4gaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChlbnYp
ICYmCiAgICAgICAgIChjcy0+aW50ZXJydXB0X3JlcXVlc3QgJiAoQ1BVX0lOVEVSUlVQVF9IQVJE
IHwgQ1BVX0lOVEVSUlVQVF9TV0kKICAgICAgICAgICAgIHwgQ1BVX0lOVEVSUlVQVF9LMF9VTkxP
Q0sgfCBDUFVfSU5URVJSVVBUX1RMQl9VTkxPQ0sKLS0gCjIuMzQuMQoK

