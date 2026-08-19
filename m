Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630C4C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 04:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwYJ9-0008AI-2A; Wed, 19 Aug 2026 00:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwYJ7-0008A7-K2
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:53:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwYJ6-0004jC-7x
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:53:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J2lS5b2766508
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=riZM2mZ6EJdTloqqe7vZG+
 1bVTYL5c5DZBXcah3f98c=; b=QCPGNXl5XVZly5LGRLFAu2PF/j/MaCViNo78as
 FZSd73w677lqQazhBLA8l6fhXYXUb9Nss5yJpQXOxvZTar/+5L4qigoT950YyZXA
 J5+tnWyRkqTkl0whnEqUII3SIX1edsqijFAlbUWNB5Tj1o+9G7Dj4yE4RVRQnDb/
 vZzXGyv58Wo3fdzfB9ifK8LkJqNb2s/wnpyZxLPw9WHFj9kgR3KAtwAA5JV6CGNG
 J8ZILEVuEPceJDNpWvrVnJ9xhkkVf496pgVO9Sh4YN7m9/iIuzHMs8N7nOrh6tJ3
 +qHk2Uj0pqLWoTak4Qe4iFhdvKYrzJl+aCdi+XRRh1cvOHnw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yffhaqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:53:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ce8a76df2dso12818785ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 21:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787115222; x=1787720022; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=riZM2mZ6EJdTloqqe7vZG+1bVTYL5c5DZBXcah3f98c=;
 b=MuK8P+2JIVdt+uoq68vP5+DtW956Ur0NwzV6t+8dMsc67Lf0LLRwhbXY/ZmaJlGpp3
 An72r+ih/jWWnnbJIcAotYpOQ9stwrBJ8YmuVEbG9SVBEMSQfeMAF99N3ZkDseSG+nrj
 yzfFMI9WxV+xJS/lvyhPLtvB8GKBF5bLUM5CXb89gYAIH/4alqoQQCz/qY88VfAVjyGp
 Cf/mz8XFC+7nW5TL1OTG6ZbhMRwB0NA2B6fYrlJR4LNj3DpzlS3pVtV4Ww/TQOo1JyIL
 fV6aHUrLuP2dY5cZGe6qEokPXPCr1+p/vvDxw+vj20onAtXAHzJXqp4rwzvSOmi2oP2G
 O2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787115222; x=1787720022;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=riZM2mZ6EJdTloqqe7vZG+1bVTYL5c5DZBXcah3f98c=;
 b=LWqxSZzMLruJdUzFM1KnhsfjHGU151pwNNfYkbSxuvuT1DF65CyF7Mv2dWmF4DCSoC
 7fb6Qgyys+C6joM2SHJRF4HBOZW3O4bvXyqY8SuRCISPa+Kjx8xnT2wN1K0m1bavk2G4
 cEtkiomfbmUqgHD8X5kB/lZPn2NV/MgJJ3tbLGUDPCo3FEvJVDrASLhrFKjTl631DcqV
 TNr5X12dgoTy4BaoE87DqF/Eas/W9ltD3rlVS9YZriv4gk9xC+ny8y2RDrz+/NXJ94RX
 LksQ6G7FLa9urYhbrugx4bauLb6yS2ehyEX3DfklSUpQdBovzZYxG2ywmgZNmEdoZB8M
 WVRg==
X-Gm-Message-State: AOJu0YyC3Dkv+4dcOKkR/kIhhen4CeH46WJ2RMK7JF6u2vwV3IJGh1zu
 1BQ00k1yHBXzYkHL6xOyxKE6FQHPt3jYJxZXUQMWx5X2fERiWwFr0gyiYHFjpOK1phlQkZUX6/w
 QnKCdw6WvgEtom2j9nhu+xRX4L8XGz3oXy0Cd4qJQEID+vO+DoG7CrY+HMTjhGVkN8Q==
X-Gm-Gg: AR+sD11eK8j1C6C8cIMXnvGyjJ5deF+ADMjdUqsFnKLW8m+hglyM4vF2lERisSPZQ+X
 /kiSHtf743LhPyLLXJuPQ2iPJRVUMekKoHVk3CGwDn1QDHhRcIg5skmoTtB2b/IvWgKLu8+JmNB
 yAVAH05gGIkTtJ1isqk3JHvcmfwUX/NibHefqxte10HtwCGzsBe1Ew9bL7Bsuv2L6jNJ8jBtz4+
 owyuypKcKgf5lzsUyxmcL0yajK9mohbrWyaGYj8PAiC4q34J4omXj821M7td2kUjAFIlLesGUqC
 LBkhpOUUktQ9hICUfR8vTPyuIzCGgcLG9xPtXxmPMFIawfrJYEwtxdTNCJv5FDyYjj6uRbPPfqA
 Fa9x6qZQTFoKSHTf4Vcu1UqY/QuDe+62vxjOGWz72HelzSAnp
X-Received: by 2002:a17:902:f711:b0:2cc:aa38:4df3 with SMTP id
 d9443c01a7336-2d60197e740mr38922555ad.13.1787115221970; 
 Tue, 18 Aug 2026 21:53:41 -0700 (PDT)
X-Received: by 2002:a17:902:f711:b0:2cc:aa38:4df3 with SMTP id
 d9443c01a7336-2d60197e740mr38921955ad.13.1787115221402; 
 Tue, 18 Aug 2026 21:53:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3ce17sm3763421eec.1.2026.08.18.21.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 21:53:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 0/2] Hexagon: fix icinva
Date: Tue, 18 Aug 2026 21:53:37 -0700
Message-Id: <20260819045339.3661773-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzNCBTYWx0ZWRfXxNhdbdzaciUY
 ULsVhNrx+A3i8BJVvmGLjQsTjSEUTJAXHDqZ4hHUlPRXFYaLCvaQUDlRUNqs/3QsLh+ai29PbuC
 pgapjGjbQEKufPqrzU53sMUNT/5WUps=
X-Authority-Analysis: v=2.4 cv=H5PrBeYi c=1 sm=1 tr=0 ts=6a8536d6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=tGEMmWpN5GEzi4DIMhQA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Oby-YfsJwgtZM9QmB_kKKSdNTMShqqeD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzNCBTYWx0ZWRfXxYq/Zbl3TgxW
 iNv/oWYjix5QDG0CxP5ovecQxCFA3Gx1zmDFbQvfNOQClh+brNodgWlngB4X5NAB8xIc+e1BEJE
 pNplc2Bxm6Sra3HKueXawdzsWlPt8KzhKsIwwvoU+vQi5lwrVf94FZZqFh++8pRcEFvCHvb6FjP
 VHrAfXriIP6QFoz6zpTq1i7BCGQWF4PpEIw2qkP8ZRh98XJgGETvjVyjtjcSvw33Jdiy5A2iCAE
 +UWSeTqsclvGUTozpG61ehys+Z3PcCSroMAFRW1/9B84ES7vFTHrGOQQkuNuOfDnvAtmR3C4v28
 OsqHURpuvuxWXkhnftue1EL1on58Ay6bBuf+oVW+/GRZgXIsDEY5rmjO2moJPDkfIBZYNoBaygO
 BKdtuOcFmOT3tKs0kA9jYO9JFK+ZiOMmYHfaBMineNAadQiQkhCkyQ5ChN0lijENSxKlJ4Tus/Y
 rMwbLRxta+IGG8hWy4w==
X-Proofpoint-GUID: Oby-YfsJwgtZM9QmB_kKKSdNTMShqqeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190034
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

aWNpbnZhIChpY2FjaGUgaW52YWxpZGF0ZSBhZGRyKSBpbnN0cnVjdGlvbiB3YXMgYSBub3AsIGJ1
dCB0aGlzIGJlaGF2aW9yCmlzIG5vdCBjb3JyZWN0IGZvciB1c2Vyc3BhY2UuCgpBbHNvIG5vdGUg
dGhhdCB0aGlzIGNoZWNrcGF0Y2ggaXNzdWUgd2FzIGJ5cGFzc2VkIGJlY2F1c2UgSSBiZWxpZXZl
Cml0J3MgYXBwcm9wcmlhdGUvYWNjZXB0YWJsZSB0byBjaGVjayB0aGUgImd1ZXN0IiBwYWdlIHNp
emUgaW4gYSBUQ0cgdGVzdApjYXNlLgoKICAgIFBhdGNoIDEvMiBoYXMgbm8gb2J2aW91cyBzdHls
ZSBwcm9ibGVtcyBhbmQgaXMgcmVhZHkgZm9yIHN1Ym1pc3Npb24uCiAgICAyLzIgQ2hlY2tpbmcg
Y29tbWl0IGVhOTRhYmJmYzg3NSAodGVzdHMvdGNnL2hleGFnb246IGFkZCBpY2ludmEgdGVzdCkK
ICAgIEVSUk9SOiB1c2UgcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplKCkgaW5zdGVhZCBvZiBzeXNj
b25mKF9TQ19QQUdFU0laRSkKICAgICM3NDogRklMRTogdGVzdHMvdGNnL2hleGFnb24vaWNpbnZh
LmM6NTY6CiAgICArICAgIGxvbmcgcGFnZXNpemUgPSBzeXNjb25mKF9TQ19QQUdFU0laRSk7CgpC
cmlhbiBDYWluICgyKToKICB0YXJnZXQvaGV4YWdvbjogaW52YWxpZGF0ZSB0cmFuc2xhdGVkIGNv
ZGUgZm9yIHVzZXIgaWNpbnZhCiAgdGVzdHMvdGNnL2hleGFnb246IGFkZCBpY2ludmEgdGVzdAoK
IHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAgICAgICAgICB8ICA5ICsrKysKIHRhcmdldC9oZXhh
Z29uL2hlbHBlci5oICAgICAgICAgICB8ICA0ICsrCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIu
YyAgICAgICAgfCAxNSArKysrKysrCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAg
fCAgMyArKwogdGVzdHMvdGNnL2hleGFnb24vaWNpbnZhLmMgICAgICAgIHwgNzEgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0
IHwgIDIgKwogNiBmaWxlcyBjaGFuZ2VkLCAxMDQgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL2ljaW52YS5jCgotLSAKMi4zNC4xCgo=

