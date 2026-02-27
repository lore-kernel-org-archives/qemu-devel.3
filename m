Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2023BFEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4a0-0006qe-EJ; Fri, 27 Feb 2026 15:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zw-0006pU-Sj
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:52 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zv-0006pe-HB
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:52 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RKF0GB2595723
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=; b=KdyzzL3ZVjeuhCtU
 Ff4744GjKLPbKy2zPexJGmmgw7vogQcPQTaNGYljKf//2RFGuew52p/1Yade3dfn
 gQuKnXZcCnDogZputNU54CO5QPhHJSUgPFsdLD52l5iZPQFS0AqLv454xr4Ur6jH
 vIZ1O0Celb3rjZasIrtHTa1toJn5IXZy5aNed6EFburAshB/JvIDFtjUyrl0QNZ4
 Ng1R/nGktyF+FRB3mpeVRY3PQXOXIQhunwyXtJxoC/6yCzYElDywTDfIPfjcOTcO
 QWdFcXJYPRuJLXod9OBKSWrXrBT1aZfu3ZwR95IBsi/4Q+cPdgDxL0Kk70Eiks8N
 31RExw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckj4xg1px-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:50 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-679c6ef1538so51007794eaf.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224609; x=1772829409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=;
 b=AR7nHJZabn+PY3HnGUjKehdDYpkDLbbY461fOJjNmYJRG51Aa2zf0s9DmtEQuHXRUI
 c4rnLF4eZDvwHOrDa2f/dSrYTpYmX8kzcFzPT4/t6NkRBqfPxSTxIv+DoFZtaPtAyF79
 JudwJk67cSEx0ltEGC4g6jo2x6zLsBNKo7U2BOuXtGTwr2fbrhX1RF/iow/hRIhiS6GV
 YtMbo8871k4KbD/bX0MPy8Qp2J9kB64cN/BiysEMGoL5wXO5Jo+dgXe7RTceANJown5V
 W+L+BJQjrEuAAYY1Y75otnRJzHZNpi2OpLUv0N3m3Rd7U3TxJXlHVHq1xeQ1IrHHyU+0
 Od+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224609; x=1772829409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=;
 b=mwcLO3WbCfyXgsAohXIwKjif7bpY3GXxXD7+CWBaXkkJx2B/ueYHJqRrl3PqErMEV9
 xsD94QnfYynM/oWp1KTMojXsZl9rvbETjPAOFSFSt5fCCpQlS5x6DJbAg+v8DZmNx8Wn
 LYOwYQ3Ca1vEUL/WA7AOuEufT35gm0jUkrup4ag51OOcaRPK0oOZ0FwyvSVRVBpgs9rp
 2ntbhrxeje0Z4wUW10lq/lgBPlmTyKmyRozl7xqZTqbsXOWI92s9tVqsro1O2PIuVOh0
 D+91aotKILGNgy560YCo+qyL3msXujL3YyEJhKlQRmEHRnDGvjo4wNSpm5JH0yyN38lz
 HCJA==
X-Gm-Message-State: AOJu0YxBm+UzZf6KuxhebRZ7/7uAP8z40q+kGHZFN0DJceeexDSZBggs
 EHAfaUrRGDVPE3Rw1IQ+LpxrLigl2X3QnCxOlgByjBGrri5FPGs6KGHc+qWM86/UYl4VaeihoOP
 WjRnNpr71xXQlZyMYNyLW2T7o2jO1EGeTNW3oPqW5aBQy9pascGMAkYFBdqh37D6qFQ==
X-Gm-Gg: ATEYQzyTXvYy+nf4dnbLlQY36u8hUzEAoa0Mx9xS0wkTxmRRaFuTaLovuknBHK68H2J
 czJXj/ODMI1D9KHESXcvrANHMm0Utso7fJnxg9qAHc7nbERi5RRtc+hTRoei27oVMdeX0Xr9Hoy
 VTWYbIW5NtXfoxvMw00xJtpzfEEJy1qhS4iPxBBuRCZlVvKtq9IgJc4Jd7WT/OMlbcq10SnCiXA
 4lFqF4ICo15w9NLAigOabvCw4ua+ResfWakpeXg4iwSUUlXBV4xUNuQM0HWziCZnfQBErnOlpcx
 D8dtLv8W65S1QrezskH8r30qMmmQweAQLBv1jYfqf16WFJ1U4igX82LWuhC+jUjK+bVR4+Fgiht
 Nk11mQaMv8cF9Klt3ZPI0q4yLHk9NlBJsUZrCAGboiuheagDwno92lxe12leqx/gIDUNfrw==
X-Received: by 2002:a05:6870:ac0b:b0:409:62c9:5cc7 with SMTP id
 586e51a60fabf-41626eb8629mr2559750fac.15.1772224609108; 
 Fri, 27 Feb 2026 12:36:49 -0800 (PST)
X-Received: by 2002:a05:6870:ac0b:b0:409:62c9:5cc7 with SMTP id
 586e51a60fabf-41626eb8629mr2559735fac.15.1772224608720; 
 Fri, 27 Feb 2026 12:36:48 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:48 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 11/37] target/hexagon: Add a placeholder fp exception
Date: Fri, 27 Feb 2026 12:36:01 -0800
Message-Id: <20260227203627.932864-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfXzZrBCJPBQzND
 56eQ1lBNc/GEU3oWtS3plXS+1ynQ2u2TwGoj1qUD5WSA9dLjW5Jco+EivRBerwbztLGWzMMdHFg
 zTzTKLZiyuhorg/8scZJYxkTuUrtACP+xBn/tPCyyeNKmyv25oGoMdjFdVWyweTnkMnjF0WHyss
 JBLCt656L7csh/OEnjtZvs22bPsVqCV5XS1fVAjs6HZTLpYvXGYgcjJE0W0fOUC/3vytvYmlWI1
 maJ366GMmDqxvjHq7lAxkszcvMqHZ2fUo934MlPnzJRbCs0/tVQti99ve7ogtxTSBJknAaa2+3k
 I7g0c5tu3Ytaw8PbP6qvgnxi7WRPccHawZCjCSY2AoA/HPlpO6Af82211iiVEWjde5fU9rKjGV7
 N4gXqnkS3yOAp8kpMzgsPm8bsXkUUj+WmnU5c0l+YJGm/3FEizGzXlYmiPiQw8bOYW3/h/o1Bwd
 73sPUYJy4EXgUmPdyaw==
X-Authority-Analysis: v=2.4 cv=QppTHFyd c=1 sm=1 tr=0 ts=69a20062 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=R5LHHePp8dzqxDYlWrYA:9
 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: tpLj4EnKCUVn5byc2EX4xvEmelL1xJ4E
X-Proofpoint-GUID: tpLj4EnKCUVn5byc2EX4xvEmelL1xJ4E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Fy
Y2guYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXgg
ZTE3ZTcxNGE2YWMuLjBhNDAwYmY3YTc3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNo
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMDgsNiArMjA4LDExIEBAIHZvaWQg
YXJjaF9mcG9wX3N0YXJ0KENQVUhleGFnb25TdGF0ZSAqZW52KQogICogbW9kZWwgaXQgaW4gcWVt
dSB1c2VyIG1vZGUuCiAgKi8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OICAgZG8ge30gd2hp
bGUgKDApCisjZWxzZQorIC8qCisgICogVG8gYmUgaW1wbGVtZW50ZWQuCisgICovCisjZGVmaW5l
IFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHsgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsgfSB3aGls
ZSAoMCkKICNlbmRpZgogCiAjZGVmaW5lIFNPRlRGTE9BVF9URVNUX0ZMQUcoRkxBRywgTVlGLCBN
WUUpIFwKLS0gCjIuMzQuMQoK

