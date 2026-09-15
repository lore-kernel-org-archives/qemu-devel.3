Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC46BC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4J-00061L-53; Tue, 15 Sep 2026 12:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3j-0005ur-7N
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3h-0003nb-LW
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAYj23958808
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mSFZtLAuVFymlxGuE/xeSBNBNcWYKAtnUcskIIJlCHU=; b=cMDQybN+FqNQcnPT
 KQU6GJ8iVBH/oCn9J3Z6bVaJ+TPzccnbE9B3wcHJK8SHyM6Ti5iGinH8IBC7qHNC
 W3be1UTeloX9DRvQOD2VOG7XAj4t4KsHhIWZiWzcLif3LUr1Wx62XgEIwtaMaANq
 taCnkRH5jPn6d+JIB4V+J1+bB3AtiXAOxnRYZGqzbDtBSBPPF6bkltElJepuEM33
 124dWSshTSfGgaHxelnADsytI73UxK4X995YXJTNh/SMDNyID6sMEbKtgnuziDUm
 lCeXM3fr0sGNxNOHNyMlBsfKSMfrC9/81Se9cd82f2oQZeoGjSozLBgawQCC6PtM
 qWcfFQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq2y2j24t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso5355927a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489859; x=1790094659; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mSFZtLAuVFymlxGuE/xeSBNBNcWYKAtnUcskIIJlCHU=;
 b=fdJ28gSaaKi1CDmaKAKnEwGrZoexibRtt1JQ9YYMJbydFn4dyq2wHqR40wi3eewncT
 S8Dbkl+ExQ7xIKJtgj9biyTK19AIUee50/ChXRszdmIs7CHHsZW6OTIzJG8lNDJfqsNA
 sUaQEoY8LIJ9dC4n2wWHjTEhydZglXf87ia0EnTofDThXmy1/FsM8zeWjySroWsgfELh
 fcLBUFNX0Et4t+I4opwgVCnxbVNRLM5p5ygWe+6AdRNPwFGEliVvHPPDNi3U2O3Iqcsb
 LfHOn1pCQEKfptwGBvBzftEpENh9oJ8WIUNLvjVeHvrEzfTtbfpwSGu2w2GxJQS4gXAL
 ciow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489859; x=1790094659;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mSFZtLAuVFymlxGuE/xeSBNBNcWYKAtnUcskIIJlCHU=;
 b=wprBkQemICOSCNDAvUoYgjKftDbsBbn3bXI/+oVvo68s19M3PwwXW5qEpil1xIOGWY
 eF6z0yACpIZ+9sbAsoNEFvM1GFdsS+5Xb7BO62CLj5y/uqOQ2+0yqyrieRYCAwS1h489
 eHkTwFMp5OZM18ptvNY5tj9pxYnGXEFu0BDk3NYznrMMsuhtswks8unqgQktZTRgpA6Y
 HHw8DZTg209CLgRsWtnwNJz4zwCc6J6I4Oll3l/IpR6/h/7/a9Oay1WULPDxah0RHXnL
 nzvIhZ5jeeLTwCNUmVF0J9Er/dDtsSUk2/IvdwIQ9xNgi/phgbE1BRkYbH8zbeMyHVBD
 RY8A==
X-Gm-Message-State: AFuF++m0is/Q0kOJMpHZaW3f2Yo9ob+SDL+oyc6uWxuicxQrofwuWwIG
 RdFK4jKZaRwFj3mxtG0+P9PTaDdGEXYe7GhQuflj3PpqRGfLEjfZPmG1tWasaHubbNBZk00h+oS
 vUnVfBSQA+LcDVnjr2HgbJvf7nkLYAQ5lfEZKOSRSHJMWZSk++jtD9IklAxi+BQObFQ==
X-Gm-Gg: AYBFou2S76NJGm/UZwaie6E3cu+xWTBJAFPyCvuaEepcO2oJU9FKxQ96T0pxT/gIpez
 /mdg9udIoaFycO3Mw6ltqbQrgirhRDtfoFjwJW0UMqJ7/FvLL7p+eLA1J43zMN/ufKJtd8N8+6Q
 D4i/9uY169vZ0ggQZAn3GE4adsJlvykCaC+GT8lX2ohHqaWDr3N84Xs+5Q+FlZMbamqILVyDAxb
 Ze2yRfM+n10XLMeqtkZMU0nJndGH3sL5lJWkEhGkEoDZhIF3BGkWGX24AatS2a9whpQ6vD+j2+X
 sJlbYpjGMnen7T4eed2hHy/uAJgNHtLTPAdhZRquy4COeLxbVad9sXxTOQjQuwp+bxDIkiWEO8/
 HQbZ2rl+PjCLP0/vx1PzAJ7NvbcWtvk03iDF+G8u0I5b2/BJ8
X-Received: by 2002:a17:90a:f944:b0:39e:1692:fd12 with SMTP id
 98e67ed59e1d1-39e1692fed9mr1428291a91.24.1789489859232; 
 Tue, 15 Sep 2026 09:30:59 -0700 (PDT)
X-Received: by 2002:a17:90a:f944:b0:39e:1692:fd12 with SMTP id
 98e67ed59e1d1-39e1692fed9mr1428209a91.24.1789489858744; 
 Tue, 15 Sep 2026 09:30:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:30:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 05/17] tests/tcg/multiarch: suppress UBSan for float-to-int
 conversions
Date: Tue, 15 Sep 2026 09:30:35 -0700
Message-Id: <20260915163047.4180600-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 3kxPbnE30QgP4aG6iEQkniFnrajY-Kxl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfX6meBBz8v70PO
 rf3cvHEa9O3ec+JKIOezyl16a/fi5zdeiAz62rzofpTghz1bk1MGldKoMTOqfGMf7ZrmgJMIvNL
 WVJr3msKMzUfLwqCbk0ewgX+lEWkL3w4mU8kcikFgldtEZ3twLzQtIlkTVKdwdI9nQuJSRI9za5
 AZ4W+xbXB46aiEo/y10os9BuGs5vyKw7BGTlozju6G8MgPubqFEEZE7ne63lHAetNVOELz6M5vg
 9M3dLUfKM8FXz2jftJqpFWfYmtap2J5Oy9CIBji+r7RZteLs/mF+k6/vopcDz2IuTMWQks8HsFP
 C/Q4JVkaY/AEomY+atXnlB7e4qy6YZedHjIYZfW17zFppPijTHLXn75WF/wFOiMpJ/wfSdhEJZ6
 6Qeecsb9Byt7sPrqz4tkqg3rxWSovNix77VUJugDzWN0EVEiS/pxUpZvTSRn6skLxZHYrwBL4V/
 AaLtcIs69IPi5I62fIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfX2oO6GRCE5J36
 M+Y/+IMb+o9G8NFNLdrKYhSgJZAuf+QX0g65tFBAigjX9ra+D64o1UCT80PL+ZrNQPo3gRwxFl1
 dFAJI62zlIxZumumgsrtxUVIEnGJYTM=
X-Proofpoint-GUID: 3kxPbnE30QgP4aG6iEQkniFnrajY-Kxl
X-Authority-Analysis: v=2.4 cv=IcISymqa c=1 sm=1 tr=0 ts=6aa972c4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=mocapJ0rodF7YK2GbI0A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150240
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

QWRkIF9fYXR0cmlidXRlX18oKG5vX3Nhbml0aXplKCJ1bmRlZmluZWQiKSkpIHRvIHRoZSBmbG9h
dC9kb3VibGUKdG8gaW50ZWdlciBjb252ZXJzaW9uIGZ1bmN0aW9ucy4KCkMxNyA2LjMuMS40cDEg
b25seSBkZWZpbmVzIGZsb2F0LXRvLWludGVnZXIgY29udmVyc2lvbiBmb3IgZmluaXRlCnZhbHVl
cyB3aG9zZSBpbnRlZ3JhbCBwYXJ0IGZpdHMgaW4gdGhlIGRlc3RpbmF0aW9uIHR5cGU7IGl0IGRp
c2NhcmRzCnRoZSBmcmFjdGlvbmFsIHBhcnQgYW5kIGV4cGxpY2l0bHkgbWFrZXMgaXQgVUIgaWYg
dGhlIGludGVncmFsIHBhcnQKZG9lc24ndCBmaXQuCgpUaGVzZSB0ZXN0cyBpbnRlbnRpb25hbGx5
IGV4ZXJjaXNlIGJvdGggb2YgdGhvc2UgVUIgY2FzZXMsIHNvIHdlJ2xsIHN1cHByZXNzCml0IHRv
IGdldCBhIGNsZWFuIHVic2FuIHJ1biBvbiB0aGUgVENHIHRlc3Qgc3VpdGUuCgpSZXZpZXdlZC1i
eTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9jb252ZC5jIHwgMSArCiB0ZXN0cy90Y2cvbXVs
dGlhcmNoL2Zsb2F0X2NvbnZzLmMgfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9jb252ZC5jIGIvdGVz
dHMvdGNnL211bHRpYXJjaC9mbG9hdF9jb252ZC5jCmluZGV4IDU4ZDdmOGI0YzU4Li5jYjM4ODRk
Zjk3NCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9jb252ZC5jCisrKyBi
L3Rlc3RzL3RjZy9tdWx0aWFyY2gvZmxvYXRfY29udmQuYwpAQCAtNjIsNiArNjIsNyBAQCBzdGF0
aWMgdm9pZCBjb252ZXJ0X2RvdWJsZV90b19zaW5nbGUoZG91YmxlIGlucHV0KQogI2RlZmluZSBz
dHIoYSkgI2EKIAogI2RlZmluZSBDT05WRVJUX0RPVUJMRV9UT19JTlQoVFlQRSwgRk1UKSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgX19hdHRyaWJ1dGVfXygobm9fc2FuaXRpemUo
InVuZGVmaW5lZCIpKSkgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICBzdGF0aWMgdm9pZCBj
b252ZXJ0X2RvdWJsZV90b18gIyMgVFlQRShkb3VibGUgaW5wdXQpICAgICAgICAgICAgXAogICAg
IHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCiAgICAgICAgIFRZUEUgIyMgX3Qgb3V0cHV0OyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9tdWx0aWFyY2gv
ZmxvYXRfY29udnMuYyBiL3Rlc3RzL3RjZy9tdWx0aWFyY2gvZmxvYXRfY29udnMuYwppbmRleCBj
YjFmZGQ0MzllMy4uNTg0Y2U4OWFhMTcgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9tdWx0aWFyY2gv
ZmxvYXRfY29udnMuYworKysgYi90ZXN0cy90Y2cvbXVsdGlhcmNoL2Zsb2F0X2NvbnZzLmMKQEAg
LTYyLDYgKzYyLDcgQEAgc3RhdGljIHZvaWQgY29udmVydF9zaW5nbGVfdG9fZG91YmxlKGZsb2F0
IGlucHV0KQogI2RlZmluZSBzdHIoYSkgI2EKIAogI2RlZmluZSBDT05WRVJUX1NJTkdMRV9UT19J
TlQoVFlQRSwgRk1UKSAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgX19hdHRyaWJ1
dGVfXygobm9fc2FuaXRpemUoInVuZGVmaW5lZCIpKSkgICAgICAgICAgICAgICAgICAgICAgIFwK
ICAgICBzdGF0aWMgdm9pZCBjb252ZXJ0X3NpbmdsZV90b18gIyMgVFlQRShmbG9hdCBpbnB1dCkg
ICAgICAgICAgICAgXAogICAgIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgIFRZUEUgIyMgX3Qgb3V0cHV0OyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKLS0gCjIuMzQuMQoK

