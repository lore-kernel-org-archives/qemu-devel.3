Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEDBCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifi-0003xM-1u; Fri, 19 Jun 2026 19:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifg-0003wk-Il
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiff-0007Rp-3V
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYkjC1287266
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=; b=iuyk6A8SLAVtDb6b
 Pbz43o4UvqnXpRAD31AjXCx7w2Ega7NShYM1xdOsEC9kQW4AdvQrwgeMU6mzutLN
 DVyvW6W0u5iJNjevfBxQWY77QedZKfHAxeZY0wihW1If9vysEvUoi3igty5gP7aC
 B6wiYspBtE+sxgvBunS8Oaxkjldyp0xW4v+mAnukCxBT1FeWH8Ejn9Qyg+73yFqE
 dRB9tanDzpr/4ZVD4va7XH4PX6/wTTNr2KqT63D09TQvRd66WIArvBwRmFrz26Op
 dzSvirTGXCe0ZGNlw41Ggo18Gbaoenv4X59Y6gJamK+h0IawinFoGcdlQ1sKG/Sc
 zc2PrQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evy72kaa3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30beab99453so4076899eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911835; x=1782516635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=;
 b=IDqP3AaUersCKMXizpqcb+pvw0qvJ4pHdsYd6AW698rs9Hmp62Mwoc5w74r4S1zXlD
 xfA6U2lVJiHFHW7I8RdSiQ6vhnil7ejmdADxQ0p418K5GKWPCKIt9tAHnLldr/kv/+tU
 ft6Bil8TPIu5SqxkmkuGuuT43KpKMgjAnFAPTgif/FQ0scnrUvj+88+f9HsD1sWn5F2A
 WgSutnC67u98C2JpB1q5ib+8mxC7mSY6uCllqxB9wRBfcpQcaCBxo2WSkWcYGBC5u5Ff
 NI7UOrDdFEun2jXuYl8A99Eu/lqyrwL19Uo5vtqQCnytiGtogPgO09ExbLCgG8KU7IDJ
 ZmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911835; x=1782516635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=;
 b=DYfvbCRbzu3I3p4kU/h7/IL/USEHLgnWNFOMMm18qFdK0xzmqWhFQJX7jNx6HB1Uvz
 qVWla9QId12WOp3Pf8YaT0sHZxKkxXmAfCzYh6HAWEpdcg9fAs3kWGNVLKmxUrRosXmF
 rwRkqdbupOsTWGuJ2d6HyalQq3OInS7SbqivyaDUp+WnRIdUDmWrqbplwvlopT000hc9
 BO8+HdyFYIR1wXabyNXT3ikINqgJI1YmuxNSe8e3F9c7d0/i+WdXco1EDYK7nFE0lNpA
 EJz4B2Jvu8FuaAufWZeat2XpcG2xKaKctHGLpN40aCv91ohaeqhVORwFyG4VLDdWjM+v
 aEsA==
X-Gm-Message-State: AOJu0Yzxm5Jfn59tPFmp9LVcPlqyb5QlqrHIrHdE5Foxgmidn8nvn+I2
 9NH7Bjlv72t9QnKFbAf1UMOk3/gGAkNtYGOQkA83t5FAPjwJbQqjNwTpC0u4HJMSvNK7OdXk5Jr
 P71KQZZHDAsTyiVD5z0hv4EFjig/CyqlBNmY9oGhEm1hp1AUWP/iklcZcJigzUhJ4/g==
X-Gm-Gg: AfdE7cm7FWRWQCRHGsRhAfvI/+5yEQBP3cr7tfWYwtmmtNKetqv6czOi4tZSp/6utvz
 3I8cHA5gARTcG5J8CKW3+dt7qlGff1z5UdlZRAY/U191sDtB/VwQ1bPQGNWt8XjqOrdSa+AkzTn
 34WyHBzhhSp+VKrdnJPLmYEGy2f7Lt6mSjK9FVUpVdQtCLEb1FJ0zvP1uPLIlF0f8+ImeboPXNm
 GaRXfqCZ0XZF5jPRpApFAhscV9FkGInl+UqA0s3B21eBYp/li0RyW0FO7ED5ZcQbS4Wz+iLa/uA
 emm3ZiSlXOm9mZ5CKBjd68BhYR+06WK1F00am4ApnNrSXk2kLGoc8rVAR9YFws/yZYtw6G84upX
 P+QbHKzYoN8n3zrvUaTd5k12q9oQpA6gSeEperj7B6uCku5V+4YZpG5gQpnU=
X-Received: by 2002:a05:7301:10c6:b0:307:e4fa:894b with SMTP id
 5a478bee46e88-30c06ff40bemr3300762eec.8.1781911835009; 
 Fri, 19 Jun 2026 16:30:35 -0700 (PDT)
X-Received: by 2002:a05:7301:10c6:b0:307:e4fa:894b with SMTP id
 5a478bee46e88-30c06ff40bemr3300746eec.8.1781911834521; 
 Fri, 19 Jun 2026 16:30:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 55/74] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Fri, 19 Jun 2026 15:58:52 -0700
Message-Id: <20260619225911.159473-56-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX/bg8yOGyR37m
 cU3zaxvX9Lh9MyjfLWMb+Uq1zcT/rfdBl/dwekelMZg9foAJc6ExL+zBO0BlSOBSZo0OGh2q3st
 I5/D+2uIWrcoLjCWA2696+CRCPfO3f/jcG0Nnc2Pbz44Ramj4PL0gdYxmJkmIyAwcfhRzhCCkma
 L6VtoZa0/36inkI6XlFfSIvDdfXqVvlFCUdUaOuFFAQa8GCzwtnIeugCrwfXpoCEWe+xJj29lwq
 Ve3d6KWNYCGjyX4MbjJfUSog6bYQeyc8yvLvamleyMtUtv/snb01532bqCj86ao9wWffcWz/hSB
 NhbcWQHjzkHVOzvE7IVfYVQt2D46gMheZCglr8XNaapPO1/Ya/7yzzA7DEZmrdwltXbofU+LXV9
 zU+6MKyi8/RMDZ7aa62TW87kJ86yZP45UK4TKzadSsh48Lc16qTMrQOCR0OcopO6p/s8vFDPNNJ
 8mLjbiDp7bqttw9upkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX6haf3o4pM0Ch
 cobQujgZThOhGL//vAfa1vaiV/F7HmFaInHhRsICaV4loZJRxvp/ggVV1V3IBla6yHKOF0jFu2Q
 PDYVawiYk2e6wjVY3b+xoDkAMa54QKk=
X-Authority-Analysis: v=2.4 cv=I75Vgtgg c=1 sm=1 tr=0 ts=6a35d11b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=c5yFZwH1WPb9xS9x6awA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -O9gfSdbHw5FwkXOsr-DeRVW1YbKzidL
X-Proofpoint-GUID: -O9gfSdbHw5FwkXOsr-DeRVW1YbKzidL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCAzYzI1M2IzOTFlNy4uOWZiY2Q3OWM5ZDQgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC0xMjI3LDYgKzEyMjcsMTUgQEAgZmxvYXQ2NCBIRUxQRVIoZGZtcHloaCko
Q1BVSGV4YWdvblN0YXRlICplbnYsIGZsb2F0NjQgUnh4ViwKICAgICByZXR1cm4gUnh4VjsKIH0K
IAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCit2b2lkIEhFTFBFUihtb2RpZnlfc3NyKShDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpCit7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhhZ29uX21vZGlmeV9zc3IoZW52LCBuZXcsIG9sZCk7Cit9
CisjZW5kaWYKKworCiAvKiBIaXN0b2dyYW0gaW5zdHJ1Y3Rpb25zICovCiAKIHZvaWQgSEVMUEVS
KHZoaXN0KShDUFVIZXhhZ29uU3RhdGUgKmVudikKQEAgLTE2NDgsNiArMTY1NywxMSBAQCBzdGF0
aWMgaW5saW5lIFFFTVVfQUxXQVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRl
ICplbnYpCiAgICAgfQogfQogCit2b2lkIEhFTFBFUihyZXNjaGVkKShDUFVIZXhhZ29uU3RhdGUg
KmVudikKK3sKKyAgICByZXNjaGVkKGVudik7Cit9CisKIHZvaWQgSEVMUEVSKHdhaXQpKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIHsKICAgICBCUUxfTE9DS19HVUFSRCgpOwot
LSAKMi4zNC4xCgo=

