Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F39606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RMgOsMG6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a0le/WfB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Sj-0005F5-5V; Thu, 22 Oct 2026 21:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Ra-0001wy-UC
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4RY-0006NE-ML
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1FjCq4008195
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lWzmemZTnmpCr5y8I/9Ml+2h/v04OIhIFXnIukoACxY=; b=RMgOsMG6F+CZMHh3
 OqqUH/XrCGw/CTVQdLQC5u/2hvnFHnG0RMypOLB1APpqV9A9tWXtYMJ5CDivVdg7
 AHa1NtpMObumEcvRN5edz8hy3IcPhfl0SS9cPi6d9yC5HGq1VtYwHXopP3I9dOdz
 NNeWpXRz7U6XWNsEA+G/Xh9/wPSlaOP4A7sNteLHgVew/0oQD3Xkwi0GZ3gCTG10
 Zqzy9e9etlUjdc/4fr3mKU5F60U9x0/he++7HlJCmpa1LeGUS1zw1So3V+hIWRLh
 JHzR3B5V/3IKM3Ou2KrikcQonLDS/Hr+MYb7vPLjL5t8tFUlM70sDS2rZvEvnpwL
 Gm+okA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmarvbv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso1454360eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720288; x=1793325088; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lWzmemZTnmpCr5y8I/9Ml+2h/v04OIhIFXnIukoACxY=;
 b=a0le/WfBqO95jxRtTmlzo/PA37aGj0WcovYhgUerg0T9C78AgAw0J3qF3SAsNNhWRe
 S/p0xfzJVnYbOuD6BwRz8x3h12aOf/9SffLkyoshW1hAojxlYeBfrt4qjnCchdqxCBHY
 9p6qj1f3dzOmgQaEbB2lzqBISaW7TVJLBpO/xYEeRsKNAyotfH/qMHlRF8006o4KVQou
 LeLV/p9l7S6UT72B0w4xVZUYDBTA6mr3somh9w6aoEeZPEL/vtOXDh8iU/a2WhhmV5Hk
 MM6TwRpuJLY67wxY9IARhb3j7ZiVkxHqByK1q7DUEU/OLi+S53chTMq9wCHe3AOnekBD
 ySWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720288; x=1793325088;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lWzmemZTnmpCr5y8I/9Ml+2h/v04OIhIFXnIukoACxY=;
 b=XM0kkNgl0hi00P7n6vgz8DEahPK0oRzW4BGoe0DQkGecSkVFEJfOy4aSgmXRx7b38k
 F1IMR/zkEaLXgDmZJLf8ivLffCFm4S5EUZ9w0gwBr635p56fuQO2aMhJPMCGx2jSNO5/
 Sx2N8UqTgoh+ntppfdOkyYmdx6CQbK8xD1KYFv6ZKyg0HwABxrun2Og/jTpI16znqkzI
 7KBZeGTJHouVz3DuQYhscSIMTf7W074f3G9FSn28j96JlIx+mX+ULLDCos8xt76Nh1cM
 a9O8uob47uciuwzQJgiX7FO/9wQA50QhOCdniMrpz/tvJUqgVGvkCTMeVE4L3m3ntH9S
 Z2FQ==
X-Gm-Message-State: AFq9FYIYCWkKMI52FeV0J6yYB7iK7UgOt2DRZVy8tfJW4jMZZKrrzSEo
 FUBoBCmvd9JxEVl5t9eBWKI0bJZbI4RQbFcPyfC/wWDV8AsHbZwWFYnXZRgStsvVEMLUb6TiGdH
 1fhgAQ3LpgJRzdv9V3XTF/9+p3X82uyngJpmeyFHeIf9VwGFPRUFcc++ZOBsbJ15mTg==
X-Gm-Gg: AYBFou04I7JEiF72Xe0ecWl55YXcTFh8HiJi8FNCUiFSW14aMtzUCSbOS5oz1zD3mI/
 Wsl21e6H5Co34TRWEneaBJJ0DWA0DfFvyDEhezmWsFR6rj6m7/jt7ep+I6um7SIN0q3FIBfnV4w
 xKkE5Sh+DKUmFdtfbJfJaiN39+hAfpwr8XhICDcBIp0lqpSfaCFjm1UZOLvLcGnMFpzWMNaAqGg
 2XoFQEy/0YvByZNZOYBbwgHx0LRlxFcvtrg3Hqgks8gSsxGp5kEbc4EUXYKCPwSRrez7jPYNy2u
 gdWb436GbK6Skj6b6bcU34i2dZ9A6PbcDOSwsuzAUqT8FyCT57iJyivjHQak/gJ25GmA83w98y0
 jQrMWAJ+QvX0/TV8YQOqSbcgskoRhVQ//w7WyVWr42aqfHQcZ
X-Received: by 2002:a05:693c:66cc:10b0:356:4b46:9393 with SMTP id
 5a478bee46e88-369d97c7604mr1136734eec.24.1792720287554; 
 Thu, 22 Oct 2026 18:51:27 -0700 (PDT)
X-Received: by 2002:a05:693c:66cc:10b0:356:4b46:9393 with SMTP id
 5a478bee46e88-369d97c7604mr1136706eec.24.1792720286977; 
 Thu, 22 Oct 2026 18:51:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 28/43] hw/hexagon: add v79NA1 machine
Date: Thu, 22 Oct 2026 18:50:25 -0700
Message-Id: <20261023015040.2473105-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adabda0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=7BVmsqUksLU-FW-GvuIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX6Agbzx8OepWP
 +s7HkufnmOdW92hjeHkW1yjohV8COhJxVkP4sNHECA3oW9AiLve1aW/BGJRuyR/VxpN6/qdT2cc
 adw7Xa+tPDvhNl46HRuyn314JwKmxAc=
X-Proofpoint-GUID: jDiKMGOGuxWenNcNI6pW-Im8ajFcyQNa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXxUhIC4ama/Iw
 +v3cJncJAURqYIWbks08yxwwfJNKo6hhHlxIbFx8SGvRQ4cPNLx6RZo9krgqzTIUXvmPC0/FnYc
 LWbtVCmrAr6S0RR7eszRCeoYF5ePnPyLPqlOVyzagETJZZoJzA8uiArgFPFimQc+GIy6/PRM/L5
 STfim5mP6yE1Btw7IQAobE/dxIMZlS8/VdEASOsTAK5jbvhYczaAUVpm+/h53s3aQLnNIlT5JrQ
 lwRlP8zHa+hAeRa9sN62FHUGrDqsAMLqHq3oYD9L+lx/Cq97ynb1ZP1qFsqNU7Yfkq7JFt2LOhM
 oGX6NMkpsj70Pe0sxrSXsqnH19TJweweaGkxz5GA+2HsEy9oMwcgc/QiY+MeiH13+7k7r078xmh
 66FeFMLnY6BnS5RiRXo0flF9gtd9kMMpfssyClHLGNR+DuaE88ydmOwaqLVRmMCIA0G+66HyNCE
 BFTdt/1OscQADHFLfVA==
X-Proofpoint-ORIG-GUID: jDiKMGOGuxWenNcNI6pW-Im8ajFcyQNa
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

QWRkIHRoZSBIZXhhZ29uIFY3OU5BXzEgc2ltdWxhdG9yIG1hY2hpbmUsIHdpdGggdGhlIGNvbmZp
ZyB0YWJsZSBvZiB0aGUKdjc5IGNvcmUgYW5kIGVpZ2h0IENQVXMgYnkgZGVmYXVsdC4KClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgfCAgMSArCiBody9o
ZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEuaC5pbmMgfCAzNCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgfCAyMiArKysr
KysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjc5bmFfMS5oLmluYwoKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggYi9pbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbi5oCmluZGV4IDFlNTY1ZDYxNjViLi4zMGZmMjQ0MDdlMCAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9ody9oZXhhZ29uL2hleGFnb24uaAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdv
bi5oCkBAIC0yOSw2ICsyOSw3IEBAIHR5cGVkZWYgZW51bSB7CiAgICAgdjczX3JldiA9IDB4OGM3
MywKICAgICB2NzNtX3JldiA9IDB4Y2M3MywKICAgICB2NzNuY18xX3JldiA9IDB4OGI3MywKKyAg
ICB2NzlfcmV2ID0gMHg4Yzc5LAogICAgIHY4MV9yZXYgPSAweDg3ODEsCiAgICAgdjgxX3NjODQ4
MHhwX3JldiA9IDB4ODA4MSwKICAgICB2ODFkZ2JfMV9yZXYgPSAweGNjODEsCmRpZmYgLS1naXQg
YS9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEuaC5pbmMgYi9ody9oZXhhZ29uL21hY2hp
bmVfY2ZnX3Y3OW5hXzEuaC5pbmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAw
MDAuLjcwYTdhZTU4YmM1Ci0tLSAvZGV2L251bGwKKysrIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2Nm
Z192NzluYV8xLmguaW5jCkBAIC0wLDAgKzEsMzQgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9t
YWNoaW5lX2NvbmZpZyB2NzluYV8xID0geworICAgIC5jZmdiYXNlID0gICAgICAgICAgICAgMHhk
ODE4MDAwMCwKKyAgICAubDJ0Y21fc2l6ZSA9ICAgICAgICAgIDB4MDAwMDAwMDAsCisgICAgLmwy
dmljX2Jhc2UgPSAgICAgICAgICAweGZjOTEwMDAwLAorICAgIC5sMnZpY19zaXplID0gICAgICAg
ICAgMHgwMDAwMTAwMCwKKyAgICAuY3NyX2Jhc2UgPSAgICAgICAgICAgIDB4ZmM5MDAwMDAsCisg
ICAgLnF0bXJfcmVnaW9uID0gICAgICAgICAweGZjOTIxMDAwLAorICAgIC5jZmd0YWJsZSA9IHsK
KyAgICAgICAgLmwydGNtX2Jhc2UgPSAweDAwMDBkODAwLCAuc3Vic3lzdGVtX2Jhc2UgPSAweDAw
MDAyMDAwLAorICAgICAgICAuZXRtX2Jhc2UgPSAweDAwMDBkODE5LCAubDJjZmdfYmFzZSA9IDB4
MDAwMGQ4MWEsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDBkOTAwLCAuYXhpMl9sb3dhZGRy
ID0gMHgwMDAwMzAwMCwKKyAgICAgICAgLmZhc3RsMnZpY19iYXNlID0gMHgwMDAwZDgxZSwgLmp0
bGJfc2l6ZV9lbnRyaWVzID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0g
MHgwMDAwMDAwZCwgLmV4dF9jb250ZXh0cyA9IDB4MDAwMDAwMDYsCisgICAgICAgIC52dGNtX2Jh
c2UgPSAweDAwMDBkOTAwLCAudnRjbV9zaXplX2tiID0gMHgwMDAwMjAwMCwKKyAgICAgICAgLmwy
dGFnX3NpemUgPSAweDAwMDAwNDAwLCAubDJlY29tZW1fc2l6ZSA9IDB4MDAwMDA0MDAsCisgICAg
ICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMGZmLCAubDJsaW5lX3NpemUgPSAweDAw
MDAwMDgwLAorICAgICAgICAubDJpdGNtX2Jhc2UgPSAweDAwMDBkODAwLCAuZG1hX3ZlcnNpb24g
PSAweDAwMDAwMDA2LAorICAgICAgICAuaHZ4X3ZlY19sb2dfbGVuZ3RoID0gMHgwMDAwMDAwNywg
LmNvcHJvYzJfcmVnMCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAw
MDAwMDIwLCAudjJ4X21vZGUgPSAweDAwMDAwMDAxLAorICAgICAgICAuY29wcm9jMl9yZWcyID0g
MHgwMDAwMDAxMCwgLmNvcHJvYzJfcmVnMyA9IDB4MDAwMDAwMjAsCisgICAgICAgIC5jb3Byb2My
X3JlZzQgPSAweDAwMDAwMDIwLCAuY29wcm9jMl9yZWc1ID0gMHgwMDAwMDAwOCwKKyAgICAgICAg
LmNvcHJvYzJfcmVnNiA9IDB4MDAwMDAwMTYsIC5jb3Byb2MyX3JlZzcgPSAweDAwMDAwMDA4LAor
ICAgICAgICAuYWNkX3ByZXNldCA9IDB4MDAwMDAwMDEsIC5tbmRfcHJlc2V0ID0gMHgwMDAwMDAw
MSwKKyAgICAgICAgLmwxZF9zaXplX2tiID0gMHgwMDAwMDAyMCwgLmwxaV9zaXplX2tiID0gMHgw
MDAwMDAyMCwKKyAgICAgICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDAwMDAwMDAyLCAudnRjbV9i
YW5rX3dpZHRoID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MDAwMDAwMDEs
IC5jb3Byb2MyX2N2dF9tcHlfc2l6ZSA9IDB4MDAwMDAwMGEsCisgICAgICAgIC5jb25zaXN0ZW5j
eV9kb21haW4gPSAweDAwMDAwMGUwLCAuY2FwYWNpdHlfZG9tYWluID0gMHgwMDAwMDA4MCwKKyAg
ICAgICAgLmF4aTNfbG93YWRkciA9IDB4MDAwMDQwMDAsIC5jb3Byb2MyX2ludDhfc3ViY29sdW1u
cyA9IDB4MDAwMDAwMDIsCisgICAgICAgIC5jb3JlY2ZnX3ByZXNlbnQgPSAweDAwMDAwMDBkLCAu
Y29wcm9jMl9mcDE2X2FjY19leHAgPSAweDAwMDAwMDA3LAorICAgICAgICAuQVhJTTJfc2Vjb25k
YXJ5X2Jhc2UgPSAweDAwMDA0MDAwLCAuQVhJTV9kYXRhX3dpZHRoID0gMHgwMDAwMDEwMCwKKyAg
ICB9LAorfTsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYyBiL2h3L2hleGFn
b24vaGV4YWdvbl9kc3AuYwppbmRleCAwYTIzMjRhNzNiMi4uMzg1NDM0MjAxNGYgMTAwNjQ0Ci0t
LSBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25fZHNw
LmMKQEAgLTMxLDYgKzMxLDcgQEAKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192NjZnXzEwMjQuaC5p
bmMiCiAjaW5jbHVkZSAibWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5jIgogI2luY2x1ZGUgIm1h
Y2hpbmVfY2ZnX3Y3M25jXzEuaC5pbmMiCisjaW5jbHVkZSAibWFjaGluZV9jZmdfdjc5bmFfMS5o
LmluYyIKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192ODFkZ2JfMS5oLmluYyIKICNpbmNsdWRlICJt
YWNoaW5lX2NmZ192ODFxYV8xLmguaW5jIgogI2luY2x1ZGUgIm1hY2hpbmVfY2ZnX3Y4NW5hXzEu
aC5pbmMiCkBAIC0yMjQsNiArMjI1LDIyIEBAIHN0YXRpYyB2b2lkIHY4MWRnYl8xX2NvbmZpZ19p
bml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkKICAgICBoZXhhZ29uX2NvbW1vbl9pbml0KG1hY2hp
bmUsIHY4MWRnYl8xX3JldiwgJnY4MWRnYl8xKTsKIH0KIAorc3RhdGljIHZvaWQgdjc5bmFfMV9j
b25maWdfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpCit7CisgICAgaGV4YWdvbl9jb21tb25f
aW5pdChtYWNoaW5lLCB2NzlfcmV2LCAmdjc5bmFfMSk7Cit9CisKK3N0YXRpYyB2b2lkIHY3OW5h
XzFfaW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQgKmRhdGEpCit7CisgICAgTWFjaGlu
ZUNsYXNzICptYyA9IE1BQ0hJTkVfQ0xBU1Mob2MpOworCisgICAgbWMtPmRlc2MgPSAiSGV4YWdv
biBWNzlOQV8xIjsKKyAgICBtYy0+aW5pdCA9IHY3OW5hXzFfY29uZmlnX2luaXQ7CisgICAgaW5p
dF9tYyhtYyk7CisgICAgbWMtPmRlZmF1bHRfY3B1X3R5cGUgPSBUWVBFX0hFWEFHT05fQ1BVX1Y3
OTsKKyAgICBtYy0+ZGVmYXVsdF9jcHVzID0gODsKK30KKwogc3RhdGljIHZvaWQgdjgxZGdiXzFf
aW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQgKmRhdGEpCiB7CiAgICAgTWFjaGluZUNs
YXNzICptYyA9IE1BQ0hJTkVfQ0xBU1Mob2MpOwpAQCAtMzE2LDYgKzMzMywxMSBAQCBzdGF0aWMg
Y29uc3QgVHlwZUluZm8gaGV4YWdvbl9tYWNoaW5lX3R5cGVzW10gPSB7CiAgICAgICAgIC5wYXJl
bnQgPSBUWVBFX0hFWEFHT05fRFNQX01BQ0hJTkUsCiAgICAgICAgIC5jbGFzc19pbml0ID0gdjcz
bmNfMV9pbml0LAogICAgIH0sCisgICAgeworICAgICAgICAubmFtZSA9IE1BQ0hJTkVfVFlQRV9O
QU1FKCJWNzlOQV8xIiksCisgICAgICAgIC5wYXJlbnQgPSBUWVBFX0hFWEFHT05fRFNQX01BQ0hJ
TkUsCisgICAgICAgIC5jbGFzc19pbml0ID0gdjc5bmFfMV9pbml0LAorICAgIH0sCiAgICAgewog
ICAgICAgICAubmFtZSA9IE1BQ0hJTkVfVFlQRV9OQU1FKCJWODFER0JfMSIpLAogICAgICAgICAu
cGFyZW50ID0gVFlQRV9IRVhBR09OX0RTUF9NQUNISU5FLAotLSAKMi4zNC4xCgo=

