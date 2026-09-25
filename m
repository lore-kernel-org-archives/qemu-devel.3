Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFABC98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9Y-00051X-4z; Thu, 24 Sep 2026 21:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9M-0004wf-Vx
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9K-0005t2-Hk
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kp2J313691
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /We6Oq3iZAEUwgNfTrkFRhUQjpmVek2fWNf2Goc+G1c=; b=SLwPh+0/dfvNRkAL
 u3Wtse6TVsN5581enI+W19izk1ZFIQJsN9LT6YWssr4+X2LIkSBaXQZHTmlZ4vi5
 7uWhuzH/alc2DvXb4ABXyh4QCSHm/mdTvSzNo3ewLwmXc8Mvw15F2cbS1R9M4enW
 kqfHJBAmTwzgTVtMTYV5hnI0XPKfbHB8CcCYYSdS1FwHgTdvuBwWr6/lBAi6dA8m
 M26xF6anSlmkvg4KMB3uwOBYxgvwP0bROK2rZGXXEuV2wZO7efXgEi3Gs8wvI3VZ
 sgZWqJEkNCO7cmiLjHPXl+eSB4EBMvbPhJw2yvfTPF2axe+gxTM7Kc8+5KIZ3MF1
 +i448w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s93d7r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341b0999491so196374eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301292; x=1790906092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/We6Oq3iZAEUwgNfTrkFRhUQjpmVek2fWNf2Goc+G1c=;
 b=dosymtRyHNEcJ/hfdDTEdckEgE9R/7wfMVLrNFVUE1YwW7oGtshGiVL9eRL9lhLegn
 S+RWhVkP7hPk7JfiXYKDiK8RDnADbiye9Vj/VT+ueZ2tMGWnh534mF/InvxbQABt0WUi
 bBGUlvK1OwqcInq51hkvnGp8FD67Cqe15MdSi/brWTwkUkMRLrb64sae0QKrbrO7sHHp
 Z92GkSqY8yldNLlaxdnZK5JJQynpnEkCrAcjJ59sgqhuERe7QRa/fUtYkO6br0qW4g+S
 FSCWz79eOyyXeLzCRtwQyevvB3UeOi6Qw1fwwfLOaK4RQ+wGfSrFYHo0zuY1Ouzas7ky
 aodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301292; x=1790906092;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/We6Oq3iZAEUwgNfTrkFRhUQjpmVek2fWNf2Goc+G1c=;
 b=wVFl09VNBWfNYubQFV9pHhQ/An8RE1z+05CicGjAqi9yBWdEB2DYNUyKkvwYQ40zL2
 tYZLP1PC1WHPKpHkpzZrlo9HFZDUhmOf1qaQzho2y1w1AqHs90aNCR0D4krVN2Z0iz6M
 J/B33ORTDKuXt7Su2Jh4WzOEPZ/x4YlfcatWeS19j2Mp10M2DgEr2NlbeAAvSFIbFcZF
 LwPk8ocpohjTHnu57JbQLy8mrJlCDTyj67Nxre6jUS8co/nyEX/18mG6ti4rtINx97tj
 7F757hA7ri6M2dDUxQWGcVYsVxsPa9rBfxZCEN/o8TZsSrW7CFsPc+cdjrzHTORfGXi2
 lhPw==
X-Gm-Message-State: AFuF++kh7jxUzR9DMi+Nm4HZfg2Q8k0JQ4x4ZdQ7upOyHgaGLcmjBheP
 vNBSFStdxbejFRsZwagKE7RuQI/CWeOfSJMJdVN6/XMfktchdtVmiluNdXlCddZObG6GduSrl+t
 lhgr3phDtrbOyWU+H/iNGOwgV4iVCI6DlLHImWYDVHWG3WYl6Ma7YHbz0VmdOxv5rFA==
X-Gm-Gg: AYBFou0wzukTikvshkGCRCAbDwBtxANjun/D1bRJf4GOV6ki3MRG924otiTVxyQoZuc
 /VLU/3HbAs/poKyutWqbkTDpbhAKO//Dgb3p3ztRTxytnySmac58bISNEYPygkN2hLJzQLMl4mx
 z7G9Dj2+6ODiD58iMPAVQ6/J39daGx7b5w2k//Cl3T41csmzFRL7RVC5yyuqP9x383nYmk/gTPd
 aC2fDgWAe6waj0PYXueQd4FsEtHCmNgaWVvZKWla327N0et9nEf2FINAHl09vU9WfjQDtFiv5oo
 6TOWTUjh+tiznEn9wDTOU748rU9JAY+C9GyM+Yyu7sOjzrzFjIsdnNlKvBdyQceuzI6QIYh4OBm
 OQBeOJ05almtZuKzs55/+P8uv6F+NMmBwmuYPESxkCmOx6as=
X-Received: by 2002:a05:693c:864d:10b0:33b:fdcd:e7d7 with SMTP id
 5a478bee46e88-34006272184mr3670724eec.26.1790301292284; 
 Thu, 24 Sep 2026 18:54:52 -0700 (PDT)
X-Received: by 2002:a05:693c:864d:10b0:33b:fdcd:e7d7 with SMTP id
 5a478bee46e88-34006272184mr3670703eec.26.1790301291685; 
 Thu, 24 Sep 2026 18:54:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sid.manning@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 11/40] tests/tcg/hexagon: fix undefined signed left shift in
 circ.c
Date: Thu, 24 Sep 2026 18:54:00 -0700
Message-Id: <20260925015429.2579174-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXyiImKR4hnYWp
 YLUhW/ysjYkIh6IcqZf8SbeQ3KsAHVAOq8LqXczPnZuzxHZ8LddIdSxuQUioxtQJy/zFN/sg888
 G+xqUbjslbmEED3iOx8bcObUfr1X+ujqa2bja1hC9KMIxK0ClCWhV//9NhINc/BsMivEw+WxhcA
 8s/L7YhO8iTSGGXr/gWo9A1DXpmohoq54WhIAypBf/Ruw/VwhU6Wl7EgjV00GpfvKjISz20oX6/
 HIpbcn85tvTUuWDlfINq+HN/wdo2fJOgOErCVGJfhOcXkwHNRvp0u3Bb3U+KqiomGdVaQaDMJmI
 sb5WDGk2RMBMUUwJVX3b9CILEUPYAJOrbYrmSLUUOiyg2cp3CDtwrBa304fjgXsGERFQM4WP6j5
 7hIqx5oyrRdr4/xmnE3HymFpuXU2kLd0S6sKISygW25A0sMh/0SL96IJ7aSJzsGLNZN5wbOFahA
 vt73i9Cdz1qW28UIhhA==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab5d46d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=czf7IwGEd3W-wTYbEmAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX1Dx/mdzlTKjD
 g8m1h3m77CCrhhrGXBQ7WzQJ5uaLCsGfiFBrRqEx7nUWgTiNXDEFawUv+Ef9oJiKpXb1/IzGaRv
 uW86BGNX1u725SDSPqNfWxopX5fWcjA=
X-Proofpoint-ORIG-GUID: d98UpvamruJfdl-qRCN37iZPSFXNgQUf
X-Proofpoint-GUID: d98UpvamruJfdl-qRCN37iZPSFXNgQUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Q2FzdCBvcGVyYW5kcyB0byB1aW50MzJfdCBiZWZvcmUgbGVmdC1zaGlmdGluZyBpbiBidWlsZF9t
cmVnKCkgdG8KYXZvaWQgdW5kZWZpbmVkIGJlaGF2aW9yIHdoZW4gdGhlIHNoaWZ0IHJlc3VsdCBv
dmVyZmxvd3MgaW50MzJfdC4KRm91bmQgd2l0aCBVQlNhbi4KClJldmlld2VkLWJ5OiBTaWQgTWFu
bmluZyA8c2lkLm1hbm5pbmdAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29u
L2NpcmMuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL2NpcmMuYyBiL3Rlc3Rz
L3RjZy9oZXhhZ29uL2NpcmMuYwppbmRleCBhYjk0OWViZWYxYy4uMmExNWMzMjQyNDIgMTAwNjQ0
Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL2NpcmMuYworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9j
aXJjLmMKQEAgLTk3LDkgKzk3LDkgQEAgSU5JVChkYnVmLCBORE9CTFMpCiAgKi8KIHN0YXRpYyBp
bnQzMl90IGJ1aWxkX21yZWcoaW50MzJfdCBpbmMsIGludDMyX3QgSywgaW50MzJfdCBsZW4pCiB7
Ci0gICAgcmV0dXJuICgoaW5jICYgMHg3ODApIDw8IDIxKSB8Ci0gICAgICAgICAgICgoSyAmIDB4
ZikgPDwgMjQpIHwKLSAgICAgICAgICAgKChpbmMgJiAweDdmKSA8PCAxNykgfAorICAgIHJldHVy
biAoKHVpbnQzMl90KShpbmMgJiAweDc4MCkgPDwgMjEpIHwKKyAgICAgICAgICAgKCh1aW50MzJf
dCkoSyAmIDB4ZikgPDwgMjQpIHwKKyAgICAgICAgICAgKCh1aW50MzJfdCkoaW5jICYgMHg3Zikg
PDwgMTcpIHwKICAgICAgICAgICAgKGxlbiAmIDB4MWZmZmYpOwogfQogCi0tIAoyLjM0LjEKCg==

