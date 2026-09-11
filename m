Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE3CC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53lg-0004cd-Sl; Fri, 11 Sep 2026 12:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53jb-0003NA-Pf
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53jM-0007YU-D0
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEmAcR222577
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1DnlqbmdnIcIbHd2kkYC7BFw6Hj42AYCM0V0FJH+ldA=; b=b1yLiBJK1BglPAUZ
 Af3Bj6jIv3uGO6W+RfNiu/gCKt8+Q0Zw295nvgM5iQPz8mftDME8P6KC8Dw8PDpx
 FInEpG4xiTioR/Ly1t5nTSFPMwIARejniXFduKwVbfBgZSafBoAfyp4yNPvhDHK2
 D1ohSfWbsrRtC7prDNHiGtHd9BMUlZZmWReze0EMHdSQY5INBTAe+Aa8ZRlQh9j6
 qPfGCPstOzTZMRD+UNCWg+rN+jpFphfgO+dcBirmdEyKWAnCCMBDwAQkWV9cjiL7
 qI3PPtH7j3OfPK/Z0BoK6cN/GDB9gLyEdvnzeB/wP9rwY3ZPPHdpj0JvJgv1yUHJ
 Gj4d2Q==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbdrakcr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:03:59 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4b37620eb73so1479298b6e.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789142639; x=1789747439; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1DnlqbmdnIcIbHd2kkYC7BFw6Hj42AYCM0V0FJH+ldA=;
 b=X4X73YpbtA5/Fxtcc6natHh9eLxZqPOrf2nNmZvZqQuX2nwUtpEIEZCfPzKbDFhghL
 subqf+wbPvIbfdkZpyxrvJRn++Sf1gWkb6ke/crGgJWkGZ4b5NrLY/7G3M5Kv3MkPzeF
 uXmhSZbW9CbghAfo7M8VoP7UDZRicSxgPb3BqdhHfqhHAxNY+LHRKPELCHg78ads4kGM
 QxHNkOVVvfKNWGgKAZKck7lcBYF/jei9NULEcUP4pFfeU1kLYswidR/1b+PCWlyhYpWM
 p1GPdhK9JJPodcGyALcSHUfr0sgyTkC713j9qZidt6T1hBEiz2lasyB8CmUgOlxPos9v
 GNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789142639; x=1789747439;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1DnlqbmdnIcIbHd2kkYC7BFw6Hj42AYCM0V0FJH+ldA=;
 b=Kj8LS3AyUxbBN7xQH83Dr9mzwj01Tcj/QJWcDMyLhZmqO1dgv+ABHkuJrvrXZIrXs8
 EyYS4orF/wqJtCP2eLPHBpbpVMTXv8Ec4zYpkze8ZkOAKj83RlpwM2A5b5jvB54xF6uK
 kdgrN38ppLz0VxYj4XrP9q7L4awWb1drv3L5tdFJjd4h2QNSvML3vcNdf+eP1MV6ZGtD
 CQTYQR9+SdnA/dpy49ck9H73mbn+tYAHGA7LPwmhH8QEI8IRTXOnNZvOCFWHQF03LW1C
 yVpK1oFdA7aYWsvidX+fYyYtmKtDjhbErqz2CoDwWMgdfKkofY5f77YfdcD9fqMNDgti
 6nrA==
X-Gm-Message-State: AFuF++mR9+r3scOBDGkzQvUIVaSGWiXzUwbbhLWvy3sYFbOI1G9E/X3p
 0SLRn/wCSZGsgfr7CaCF9v8/bQEahGz/QmmSHSjSkEyJYssHhR2YqqiScSgd/wN63yzNiPHskrA
 g2ycEuvsOVjqN5P5FbozQHxqO//ieZc3UApmVrG421Yf1b4tCZ6WGWIlQAYgB3AoFTw==
X-Gm-Gg: AYBFou3/yE6u9W+O3UniJbGDJvWu3acgtwyBGRm3IHPGxL+QchrrfhqQQ1NsNqKioKh
 H9Cd7ZMIb0RPavs1HCUCdmfgJM0TIjRcaZZDWsCeRr7/WgNVP8dR6/B/pinnwR+gOWAup4gzo4N
 U5FzKsxlD5QH+9+JJNMOZO3OwcXqpM1gW8iS2thJ+xzLV2MQ4JEhiQMECq2rSRB7Ep1NxP0A5/S
 3ht7qbrMcdSMQ7YV5P8PpTK8uKz897ovZdmjo0cK95kRr8OStW1vqFZkNd2NatzaJO1ISqMKCSq
 AvMGGHggEFjhpcc1zW8QKCcLvsZjUCImHzPFubjgcJwtrD6hllvZU1Pa4nm5rqItSExyx6tPLJJ
 d+bOx+foE2XK1zGQ5L/8Yd9JzJToVYvlCrVEs03EwbDPYG5hG
X-Received: by 2002:a05:6808:3985:b0:496:11f1:f2ad with SMTP id
 5614622812f47-4c31a282846mr7318362b6e.6.1789142638696; 
 Fri, 11 Sep 2026 09:03:58 -0700 (PDT)
X-Received: by 2002:a05:6808:3985:b0:496:11f1:f2ad with SMTP id
 5614622812f47-4c31a282846mr7318305b6e.6.1789142638260; 
 Fri, 11 Sep 2026 09:03:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3321ecd0asm2451876b6e.17.2026.09.11.09.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:03:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 06/10] hw/hexagon: move "sim" alias to "V81QA_1"
Date: Fri, 11 Sep 2026 09:03:03 -0700
Message-Id: <20260911160307.865892-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
References: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: _fElp6EBC67ovsFtQBVs6t8BGPLJfQXd
X-Authority-Analysis: v=2.4 cv=PLmaavqC c=1 sm=1 tr=0 ts=6aa4266f cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=kk5yy-eOBfP67cS8hnMA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: _fElp6EBC67ovsFtQBVs6t8BGPLJfQXd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX9jNVrzylaTIp
 axEboTnjwx71yTyize/n+UzN2XlTmhJy6W2T3O9dVdtPoNthxAItLhXuKseo6ajSATAmPjzVwEq
 WkFMNV5G2cmIqgvBwvurx7a2f28bw58=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfXw4Y36UOOL2hx
 O/k0Qh4UI/czPtZC7E7DiLDx1kR5WLQMkfOx5Z8qmb40NQLPR+ApxNAzcKIqwLjGibeeZ2XVqv0
 tTKR7bdp1BwQE3LwHzXqCHkZOaOSbIwaHbiJWdn5SLoJ0aSH1/wf/LNNe9DIvL4zGcPVQRPypD4
 5uMf1gpw7OqVKzlZnTthea65Pptc/J6Gfe0sgKLSvAdWnYR5gdxV7XLbBWiuzCg0b1hsQs+9S7k
 iuzR08sbRy8W/2O0Jb1BoRABKkjYHctXgdqn7K8iwuicB1EvUerZCP/HLBF5Rqokz2zmtyo/xhh
 ECqvR2ZXAUh+q1cmVaAnx9eYi+WzsnCBokEI9mRmNnfz32++DkwpiZr+gQf+N+6Y0zN6BxsyjDy
 jF4OevLCJ33aKaEzJ+4Q9v3Wp+UpflQPMrDy4KzfDE1WHxv9agfcU0tIQY/e4ljVD4mQv/q6mO9
 ZnoH+WivL605rWBBJ/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110224
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

VGhlICdzaW0nIG1hY2hpbmUgbmFtZSBpcyBhbiBhbGlhcyBmb3IgJ21vc3QgdXAtdG8tZGF0ZS9j
YXBhYmxlCmhleGFnb24tc2ltLXN0eWxlLW1lbW9yeS1tYXAgbWFjaGluZScsIHNvIHdpdGggbmV3
IHY4MSBtYWNoaW5lcwphdmFpbGFibGUsIHdlJ2xsIHVwZGF0ZSB0aGUgYWxpYXMuCgpSZXZpZXdl
ZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3
L2hleGFnb24vaGV4YWdvbl9kc3AuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3Au
YyBiL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwppbmRleCBiZTE3YTMyZWUxMi4uODgyNGZlMTBh
NTkgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYworKysgYi9ody9oZXhhZ29u
L2hleGFnb25fZHNwLmMKQEAgLTE5NCw3ICsxOTQsNiBAQCBzdGF0aWMgdm9pZCB2NjhuXzEwMjRf
aW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQgKmRhdGEpCiAgICAgTWFjaGluZUNsYXNz
ICptYyA9IE1BQ0hJTkVfQ0xBU1Mob2MpOwogCiAgICAgbWMtPmRlc2MgPSAiSGV4YWdvbiBWNjhO
XzEwMjQiOwotICAgIG1jLT5hbGlhcyA9ICJzaW0iOwogICAgIG1jLT5pbml0ID0gdjY4bl8xMDI0
X2NvbmZpZ19pbml0OwogICAgIGluaXRfbWMobWMpOwogICAgIG1jLT5kZWZhdWx0X2NwdV90eXBl
ID0gVFlQRV9IRVhBR09OX0NQVV9WNjg7CkBAIC0yMjgsNiArMjI3LDcgQEAgc3RhdGljIHZvaWQg
djgxcWFfMV9pbml0KE9iamVjdENsYXNzICpvYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBNYWNo
aW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7CiAKICAgICBtYy0+ZGVzYyA9ICJIZXhh
Z29uIFY4MVFBXzEiOworICAgIG1jLT5hbGlhcyA9ICJzaW0iOwogICAgIG1jLT5pbml0ID0gdjgx
cWFfMV9jb25maWdfaW5pdDsKICAgICBpbml0X21jKG1jKTsKICAgICBtYy0+ZGVmYXVsdF9jcHVf
dHlwZSA9IFRZUEVfSEVYQUdPTl9DUFVfVjgxOwotLSAKMi4zNC4xCgo=

