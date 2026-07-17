Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B269EC44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2Q-0006lc-5l; Fri, 17 Jul 2026 15:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2P-0006lD-1n
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:15:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2N-00083i-95
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:15:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGo5qn2372091
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mxXJevFcd/n8CZD5ELOwHmvJeo9/m5LpxRY+ceTLUBY=; b=jbmW0mYWvjbPB3Uc
 /IVeYcfAasPCHQ0lOlUI9e72j7ZxweYioHm7nYH6MO+gISwEoxY8P+g2j+j2yB7J
 eFrd37a6XUlT1xaqGL0qS+u3gv3UCM7ye5IomsG7U+LFqbQKL3KCF1h9rw5fk9gU
 tJptl1P3eyKaHoJGr5ClXSn2KE5KXRiVNdLEnvH5qOwoG7rc2QwqCSfQ3dbGKLpa
 YmbeXFE/7seBQ+O6oh2pg6b9GjCl3lP+T2jOSau5N8MaeU1V6nR5HDkkJY9ADv41
 vLHYEstRZnjdkvcHByq+XAhW3dfJR0Gq9L8Zc3yDJHW5o3Pc7rcOEx5ClTwlzJyp
 OIlmlA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gu00y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:15:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so143977675ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315753; x=1784920553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mxXJevFcd/n8CZD5ELOwHmvJeo9/m5LpxRY+ceTLUBY=;
 b=Bz8Uysl8Lsb32mpqAexN+h061W9TeBFpSI+/M+5a4Zt6aFM8yYTOIyCTvS0GKnLnH4
 Ta8gN8sJBzQ8BvHEkZf2OciYOsZp+Zq3bsFo7sQISCzgugeXxUED9hTUBqrfeGkkFVcz
 lG86t0TtSe9h1ooWcuzal7GHdMo9I+SUIT2h+XdrV18KPKmFJQf21cX86UeU62VQFwHG
 yBCXZ4bHT/C5LYDN6S5zMhfgUNnEDeB77viu+5YjEQkgmupt0rJgph854/344genhkL4
 HaGuVtSYMSIjrnf5UcxDfFcnt+6avzxt0DtaDvrZSc/OsAIqYTfa+6vkIOsaq1a9QMP2
 OFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315753; x=1784920553;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mxXJevFcd/n8CZD5ELOwHmvJeo9/m5LpxRY+ceTLUBY=;
 b=rPHwmzFdnqGaimGeYtNspGLoxgSLPd/PAzEVvP269eeUYr0j6IF/fpFqvn3tDbQh6q
 tQbyhSeICRQ99Bq0SplYXR0QH6rK7YY8P0XsRNiosLSh9aT5GEEPjOe5+pmy0NfV+Nta
 4/erWueBi2ErPpyFR2+IIAhjWHTW0h7KFTj+jr1JEbxJvB9EQ1vaBQnUisrfGFOCOwQA
 E6vknj7H6+2c+d43XTY0g7ko6x0nvTuXYrWOfXZq7VHKoxLXGVEXZEjZdxXNDf1hZT7N
 VvPXx6kSVvLJn2oQjyHwevYaf/5x5tEJipO5NcrG/yAiudmO1UhJGdyhyKzRuBac8WpF
 g/XA==
X-Gm-Message-State: AOJu0YwXZ2etg083/Q1N1rYn1I8c0XiwjjznUE8hTPi3OMsd+pkUCes0
 NGs7ELVQtL7OuAvjMAvuJJeh5ZQGWxuvE6oFyNnKWxF63KocpGOM6wiTjSk/RHi9LccwY8tTBDt
 D/O45VphMXCBy6Hz0kYw6kQzOrwkR8fQb1jcy/Am6O4eKTkj143D9ZKA7XPhiDoxKtA==
X-Gm-Gg: AfdE7cnGcTB6+YfL9xhx8mSpgVB2Q6YqlNW4HKO3H9tWydVJlB3KflwiQkAoENwGlZd
 Ul4PwJYcTojaC4uIHBBBU97tZiywJxYtD9aVIsKW5dQZqNRvVY/qBuif/C4xIWoU2ZPqwhixKgT
 elnOk5X9wPN0HIDfu1K6HbN3ENg77N/usMQ3nTXlF0IrEn/bW9tKbFqwLfFutxoF5HqtxHn/yU3
 R52pIImHbk3dPq9XioYzzYu+ngGyojRJiMvzYWV09eVWFL04khFn3hdeS6Kw8t7UAVRRdSeToT9
 koWCPF6XE0AvTadfL6d/fhG1lK74dOeDhET9DxPZrAQPLtM2OzZaZO60Ul9ZJLO/i52BJiNoMZH
 +xRCET41sCHsNGl50dtLGo0zXwkFval084GD5AqVerpYMyidm
X-Received: by 2002:a17:90b:250f:b0:38e:4b60:e01 with SMTP id
 98e67ed59e1d1-38e4b602953mr2849022a91.12.1784315751944; 
 Fri, 17 Jul 2026 12:15:51 -0700 (PDT)
X-Received: by 2002:a17:90b:250f:b0:38e:4b60:e01 with SMTP id
 98e67ed59e1d1-38e4b602953mr2848995a91.12.1784315751519; 
 Fri, 17 Jul 2026 12:15:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:15:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 01/12] tests/docker: hexagon fix podman untar, 22.1.8
Date: Fri, 17 Jul 2026 12:15:36 -0700
Message-Id: <20260717191547.920048-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX17CMBKq+WG87
 c8AQV2DzS6+v/1hedCpr0x7/otvIxCUtQQkckQdTNlFDrB1gbLmElBCYo2QqrEy3xa8KVQUShf9
 ddbjExTLa68SR7gCs+Iwx8gUJ3JlASU=
X-Proofpoint-ORIG-GUID: -q2oOUTAYuglOiqfsNLnm38Dgx_BMEgF
X-Proofpoint-GUID: -q2oOUTAYuglOiqfsNLnm38Dgx_BMEgF
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5a7f6a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=qC_FGOx9AAAA:8 a=Twlkf-z8AAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KiFxOH7L81jTK52PPKYA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=fsdK_YakeE02zTmptMdW:22 a=-74SuR6ZdpOK_LpdRCUo:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX24cs2y7qQ+gI
 lg1mG+Wc8Jgj1TDyMCV6Idx9j0TRNq+GZ3HzuvAwL+rJRK3Kfi586b/zXcqu2KFLrdZpRHKvEk0
 B+JspF6Y74V5t80w7yjKVpq3l/V/0vuXnYMV0JDHAji9HQCnJY6du1ZczgSui4EstOPM6Ou7CKi
 EMiWh9K8OZQo6rKMQpR1keArQAgNdlptdlHIEJUc75CP6O/EKSfA/q+Kjpxn/1EyDtkRJnDJbqF
 zCw1w6rRz4c/haLM16OOTkz/ZbvPKl5boCxdU9eHhM5FtYfw/NKEvvBdS2iryLYjJGCoA5ktBuM
 Jjk/DBj/3vRPkOrbmn6gcH9utQV0r276BW3NoOT4Gqb7vBejAu+NsKULd9sySINW3Zu0O3U+aGE
 mLIZWFu6PAKAz/6PtSYwpi70cZV54DLvuDt+7IUN7A3cBD9rra612ltlfpdGJYbnS0iwcU+mNWe
 6e5dIzHpjqcnal/bGNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170197
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

VGhlIGRlYmlhbi1oZXhhZ29uLWNyb3NzIGltYWdlIHByZXZpb3VzbHkgdW5wYWNrZWQgdGhlIGNv
ZGVsaW5hcm8KY2xhbmcrbGx2bSBoZXhhZ29uIHRvb2xjaGFpbiBieSBwaXBpbmcgYSAudGFyLnpz
dCBhcmNoaXZlIHN0cmFpZ2h0CmludG8gInRhciAtLXpzdGQgLXhDIi4gR05VIHRhciByZXN0b3Jl
cyB0aGUgYXJjaGl2ZSdzIHN0b3JlZCBmaWxlCm1vZGVzIG9uIGV4dHJhY3Rpb24sIGluY2x1ZGlu
ZyBsY2htb2QoKSBvbiBzeW1saW5rcy4gVW5kZXIgcm9vdGxlc3MKcG9kbWFuLCB3aGVyZSB0aGUg
YnVpbGQgcnVucyBpbiBhIHVzZXIgbmFtZXNwYWNlIG9uIG92ZXJsYXkgc3RvcmFnZSwKdGhvc2Ug
Y2htb2QoKS9sY2htb2QoKSBjYWxscyBhcmUgcmVqZWN0ZWQgd2l0aCBFUEVSTToKCiAgdGFyOiAu
Li4vbGliY2xhbmdfcnQuYnVpbHRpbnMuYTogQ2Fubm90IGNoYW5nZSBtb2RlIHRvIHJ3eHJ3eHJ3
eDogXAogICAgICAgT3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQKICB0YXI6IC4uLi94ODZfNjQtbGlu
dXgtZ251OiBDYW5ub3QgY2hhbmdlIG1vZGUgdG8gcnd4ci14ci14OiBcCiAgICAgICBPcGVyYXRp
b24gbm90IHBlcm1pdHRlZAogIHRhcjogRXhpdGluZyB3aXRoIGZhaWx1cmUgc3RhdHVzIGR1ZSB0
byBwcmV2aW91cyBlcnJvcnMKCnRhciB0aGVuIGV4aXRzIG5vbi16ZXJvIGFuZCBhYm9ydHMgdGhl
IGJ1aWxkLCBzbyBkZWJpYW4taGV4YWdvbi1jcm9zcwpvbmx5IGJ1aWxkcyByZWxpYWJseSB1bmRl
ciBkb2NrZXIsIG5vdCByb290bGVzcyBwb2RtYW4uCgpTbyBpbnN0ZWFkIHdlIGNhbiBzd2l0Y2gg
dG8gYSBkaWZmZXJlbnQgcGFja2FnaW5nLiAgY2xhbmcsIGxsZApjb21lIGZyb20gTExWTSBEZWJp
YW4gYnVpbGRzIGZyb20gYXB0Lmxsdm0ub3JnLCBpbnN0ZWFkIG9mIGN1c3RvbSBvbmVzIGZvcgpo
ZXhhZ29uLiAgQW5kIG9ubHkgdGhlIGhleGFnb24gbGludXggc3lzcm9vdCBpcyByZXF1aXJlZCwg
YXZvaWRpbmcgdGhlCnRhciBpc3N1ZXMuCgpSZXZpZXdlZC1ieTogTWF0aGV1cyBUYXZhcmVzIEJl
cm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5jb20+ClJldmlld2VkLWJ5OiBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiAuLi4vZG9j
a2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyICAgfCAyNyArKysrKysrKysrKyst
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNy
b3NzLmRvY2tlciBiL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9z
cy5kb2NrZXIKaW5kZXggMjNlOGJiMmZiMjYuLmUwN2EyYmUzN2UyIDEwMDY0NAotLS0gYS90ZXN0
cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyCisrKyBiL3Rl
c3RzL2RvY2tlci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIKQEAgLTE3
LDEzICsxNywxMyBAQCBSVU4gYXB0LWdldCB1cGRhdGUgJiYgXAogIyBJbnN0YWxsIGNvbW1vbiBi
dWlsZCB1dGlsaXRpZXMKICAgICBhcHQtZ2V0IGluc3RhbGwgLXkgLS1uby1pbnN0YWxsLXJlY29t
bWVuZHMgXAogICAgICAgICBjdXJsIFwKKyAgICAgICAgd2dldCBcCisgICAgICAgIGdudXBnIFwK
KyAgICAgICAgbHNiLXJlbGVhc2UgXAogICAgICAgICBjY2FjaGUgXAogICAgICAgICB4ei11dGls
cyBcCiAgICAgICAgIHpzdGQgXAogICAgICAgICBjYS1jZXJ0aWZpY2F0ZXMgXAotICAgICAgICBs
aWJjKysxIFwKLSAgICAgICAgbGliYysrYWJpMSBcCi0gICAgICAgIGxpYnVud2luZC0xOSBcCiAg
ICAgICAgIGJpc29uIFwKICAgICAgICAgZmxleCBcCiAgICAgICAgIGdpdCBcCkBAIC00MywxNSAr
NDMsMjIgQEAgUlVOIGFwdC1nZXQgdXBkYXRlICYmIFwKICAgICBsbiAtcyAvdXNyL2Jpbi9jY2Fj
aGUgL3Vzci9saWJleGVjL2NjYWNoZS13cmFwcGVycy9nY2MgJiYgXAogICAgIGRwa2ctcXVlcnkg
LS1zaG93Zm9ybWF0ICcke1BhY2thZ2V9XyR7VmVyc2lvbn1fJHtBcmNoaXRlY3R1cmV9XG4nIC0t
c2hvdyA+IC9wYWNrYWdlcy50eHQKIAotRU5WIFRPT0xDSEFJTl9JTlNUQUxMPS9vcHQKLUVOViBU
T09MQ0hBSU5fUkVMRUFTRT0yMi4xLjAKLUVOViBUT09MQ0hBSU5fQkFTRU5BTUU9Y2xhbmcrbGx2
bS0ke1RPT0xDSEFJTl9SRUxFQVNFfS1jcm9zcy1oZXhhZ29uLXVua25vd24tbGludXgtbXVzbAot
RU5WIFRPT0xDSEFJTl9VUkw9aHR0cHM6Ly9hcnRpZmFjdHMuY29kZWxpbmFyby5vcmcvYXJ0aWZh
Y3RvcnkvY29kZWxpbmFyby10b29sY2hhaW4tZm9yLWhleGFnb24vJHtUT09MQ0hBSU5fUkVMRUFT
RX1fLyR7VE9PTENIQUlOX0JBU0VOQU1FfS50YXIuenN0CitFTlYgTExWTV9WRVJTSU9OPTIyCitF
TlYgVE9PTENIQUlOX1JFTEVBU0U9MjIuMS44CitFTlYgVE9PTENIQUlOX1VSTD1odHRwczovL2Fy
dGlmYWN0cy5jb2RlbGluYXJvLm9yZy9hcnRpZmFjdG9yeS9jb2RlbGluYXJvLXRvb2xjaGFpbi1m
b3ItaGV4YWdvbi8ke1RPT0xDSEFJTl9SRUxFQVNFfV9fX19fX19fL2hleGFnb24tZGVicy0ke1RP
T0xDSEFJTl9SRUxFQVNFfV9fX19fX19fLnRhci5negogRU5WIENDQUNIRV9XUkFQUEVSU0RJUj0v
dXNyL2xpYmV4ZWMvY2NhY2hlLXdyYXBwZXJzCi0KLVJVTiBjdXJsIC0jU0wgIiRUT09MQ0hBSU5f
VVJMIiB8IHRhciAtLXpzdGQgLXhDICIkVE9PTENIQUlOX0lOU1RBTEwiCi1FTlYgUEFUSD0kUEFU
SDoke1RPT0xDSEFJTl9JTlNUQUxMfS8ke1RPT0xDSEFJTl9CQVNFTkFNRX0veDg2XzY0LWxpbnV4
LWdudS9iaW4KIEVOViBNQUtFPS91c3IvYmluL21ha2UKKworUlVOIGN1cmwgLSNTTCBodHRwczov
L2FwdC5sbHZtLm9yZy9sbHZtLnNoIC1vIC90bXAvbGx2bS5zaCAmJiBcCisgICAgY2htb2QgK3gg
L3RtcC9sbHZtLnNoICYmIFwKKyAgICBERUJJQU5fRlJPTlRFTkQ9bm9uaW50ZXJhY3RpdmUgZWF0
bXlkYXRhIC90bXAvbGx2bS5zaCAke0xMVk1fVkVSU0lPTn0gJiYgXAorICAgIHJtIC1mIC90bXAv
bGx2bS5zaCAmJiBcCisgICAgbWtkaXIgLXAgL3RtcC9oZXhhZ29uLWRlYnMgJiYgXAorICAgIGN1
cmwgLSNTTCAiJFRPT0xDSEFJTl9VUkwiIHwgdGFyIC14ekMgL3RtcC9oZXhhZ29uLWRlYnMgJiYg
XAorICAgIERFQklBTl9GUk9OVEVORD1ub25pbnRlcmFjdGl2ZSBlYXRteWRhdGEgXAorICAgIGFw
dC1nZXQgaW5zdGFsbCAteSAvdG1wL2hleGFnb24tZGVicy8qLmRlYiAmJiBcCisgICAgcm0gLXJm
IC90bXAvaGV4YWdvbi1kZWJzCisKICMgQXMgYSBmaW5hbCBzdGVwIGNvbmZpZ3VyZSB0aGUgdXNl
ciAoaWYgZW52IGlzIGRlZmluZWQpCiBBUkcgVVNFUgogQVJHIFVJRAotLSAKMi4zNC4xCgo=

