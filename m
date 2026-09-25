Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7915C98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9k-0005B4-5U; Thu, 24 Sep 2026 21:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9W-00050o-Kc
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9T-0005uW-KW
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kn593181623
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vNShHZghpbuiIrDbee5B70iKjzeo4xm23uRv4HjxN3M=; b=MRQUHlw/NPCghARL
 dBqdV3zr2GVmsI/mCGIdZUNKiu+JmnHjY2LHK9lSSbgLzQH9dcBA1HD/LMw//sPb
 LuYlzF1TEabJSEcn3rml5FB6rsuUqQyiv5TZDDIG7Tof1O0QPuvROlPsaHyYYidE
 OyhXNMHoz5It4qKj24lrnY4mxIv7+BVjZweRIs5jTAsVDlJLM1wX+L47d13HKi0W
 QLY1aR7+0xsqNY2QTlVD4KQlwmr9QK7Ieh19V4RVgDqmDJKTsN6J46Uzb8R/TDLT
 0WtBWbVWtwua+Q+5BglkMCQFF4LW4f1xi4eb+JFNhFNgzQAqfMwTYsGxfEJovKlx
 96JjmA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94k99eq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33baaba6371so1434478eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301301; x=1790906101; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vNShHZghpbuiIrDbee5B70iKjzeo4xm23uRv4HjxN3M=;
 b=aSQtkVy7/UEvoTnxuidn8iGBW4LhckXk9FmZNlGTsWkO49pgjtney7MKZxnxgXvkv8
 qhd02npMdvTnidtynJhhMDRS9hbnopsw68SXB0e3/WvVRwIskIH0OhpQddowucia0dfL
 /bxP1bmTXYIZCxt0C9i38VvQ0YtzIWPTQN4cUqA5KXwosUnSTPRfjugolItB9TrQyj8d
 fypn1VLWiJWjRTR0edJ1fMVJyd64py8nDMLYUYgyizmRro6NxJi5qiFOEQ3fw2O5fFJa
 4/4EVbg45I/COSZSUATejnz9DgRFSpeMP/ARMy1adGp9+WX/Qpf4Kn5W60uqNzC/TMcc
 gSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301301; x=1790906101;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vNShHZghpbuiIrDbee5B70iKjzeo4xm23uRv4HjxN3M=;
 b=smk+mh2INQbH9724BXrbB5hBxVgTo5sY/LGC75cT5HjaLuj2QTKSdfgfgD4AhojzH+
 eDjejZIo0ITSN/VjK+IORtp4LEP2GJLqW3/lGVPwh4giPgCtAYhGPUnWXIsOJ3mM3hc4
 rFHn4akKkeD7G0mFqEz/Tb3do6VKg7G6SVrG/uqnwamODvFtQrSwu/44Bg4EDw59+Kn5
 zJo/zvuqFxjAeuri1tyie6HujLVCMBMu7qW6vUMSmhjoKaiXdIGgk8KQRnNwYGa9Tqrd
 lOSMV/Q0wjNzoY+uAJDUnfmcklI6JjQ+HKcACXnBtjfAWpFlHZPMyyRKxLcg+CdBV6+x
 H4rA==
X-Gm-Message-State: AFuF++m2HCzsYstBHhShVRW/jl/7CLoVxx5hSUQjolApgwda7boaHIZa
 HfKsK95GRyX/ILMWtIzN/jX2T9QTza/1Q9dh/K9JN9BOHzdaUH1hVJnlWYXbnZ9bjtpeeaG8w5C
 fxkYETA99hinGyCxKMbCdSq/qKNUYD7TORYMMpLo85/pVAgDVLMfeAvho40jbNHRJ5g==
X-Gm-Gg: AYBFou1FTCGlAQKdjac/wObCBVGW8DCh+6Ogxo2KEQdtONyUdBFgn+5Xv4nkWQjUcZ8
 UKw+f2R4yzPH7/StVmx1IblXDjtYbunrwAHTLcu/4u0yGP0MKej4AK7YqVXTdfL9D4eaQlKD9eh
 Kht+AlM0Jk3J6EvsREGghIkzB0gEygvakfrhj53ZxrzmUsjTn0njOfITSMLr1En8JhRpGiDvQVq
 0lySfdaAyUFEwYZR7Co+21y+7EHidy3M0mB8J6VqME8se/9KZJyHUeFuzIDofh2lFr02A1Zp3G8
 pSNOO4eAjUZ4undTPsWrOsodsrNEzQPrutF+dE6K/axqCm0b/dvjKgxBzYrKAvidynMgK+XE0OF
 rxLXf5W4cEkoKsVqMIkEFlC28fd1ARBUgd2jbWXsjsLn90TM=
X-Received: by 2002:a05:693c:66cf:10b0:33c:e9d:6d4b with SMTP id
 5a478bee46e88-34003cac91emr3358007eec.41.1790301300709; 
 Thu, 24 Sep 2026 18:55:00 -0700 (PDT)
X-Received: by 2002:a05:693c:66cf:10b0:33c:e9d:6d4b with SMTP id
 5a478bee46e88-34003cac91emr3357992eec.41.1790301300068; 
 Thu, 24 Sep 2026 18:55:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sid.manning@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 17/40] tests/tcg/hexagon: add bit interleave and convergent
 rounding tests
Date: Thu, 24 Sep 2026 18:54:06 -0700
Message-Id: <20260925015429.2579174-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aaj0Dhot c=1 sm=1 tr=0 ts=6ab5d475 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=MD3S-f5BDBJKRhxJpBIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: lCz63urC8HeD9my0CXRTdes7FaEphnnF
X-Proofpoint-ORIG-GUID: lCz63urC8HeD9my0CXRTdes7FaEphnnF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX1o7hHStE8R+T
 LeMVK1hzMiVLpG+Am9bdFE5WG7im3OFdWJ5r15Rx2mbhWehVncdWktb4BHzjfHJJhPBzE/eOFjO
 gKnmz16qA/j+qSzTooh9XwojDb42/huxGlv8lybJa/kRyv+j60absxAH1EZGwA6YpfXEEpxkznI
 oeXPepdeL3LTWVotZLMP3hHqv7fi1Y/GXcFjC3DDclMThU/9/w5fbIvLDc3aIpkU11kc9OXmMfW
 XzH90x5OYuWPCBb+exuax8uOx45utHTrdCpZIp3kuuuL0RZUZQgxj5J699dxRXC95hRAN/zZq+I
 3X5JD81kS1v7R4XG+zaUqy3pBNmW2g2DpyO2qM1Mb2h4LXokQm2s4y2vIdXZRjRlcWyPAQR2sKk
 c2ALEGmJ/gPYtdXMzoGQQcou8Yn+lhlZ8sH+pC0XjxksnX/emMDvO2647CF5d0GaMMjI+Aige5F
 312oPkPHoBg805n24vw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXwhO0Hwxox8K2
 EdgJBzp16q3j1zqW4bRxQINQog1QKrKtho0b804sCHaU2af50wcxRatEHb7BojTdl+NrvRfBYOx
 6vBG9A7ezzJIkBQahF0eemPr0zyzC0E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

VGVzdCB0aGUgaW50ZXJsZWF2ZS9kZWludGVybGVhdmUgNjQtYml0IGJpdC1tYW5pcHVsYXRpb24g
aW5zdHJ1Y3Rpb25zCmFuZCB0aGUgY3JvdW5kIGluc3RydWN0aW9uLgoKUmV2aWV3ZWQtYnk6IFNp
ZCBNYW5uaW5nIDxzaWQubWFubmluZ0Bvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNnL2hl
eGFnb24vdGVzdF9iaXRvcHMuYyB8IDk4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQgICB8ICAxICsKIDIgZmlsZXMgY2hhbmdl
ZCwgOTkgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29u
L3Rlc3RfYml0b3BzLmMKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2JpdG9w
cy5jIGIvdGVzdHMvdGNnL2hleGFnb24vdGVzdF9iaXRvcHMuYwpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMC4uM2U5Mjc0ZGRkZGQKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0
cy90Y2cvaGV4YWdvbi90ZXN0X2JpdG9wcy5jCkBAIC0wLDAgKzEsOTggQEAKKy8qCisgKiBDb3B5
cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlh
cmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8K
KworLyoKKyAqIFRlc3QgYml0IGludGVybGVhdmUvZGVpbnRlcmxlYXZlIGFuZCBjb252ZXJnZW50
IHJvdW5kaW5nLgorICovCisKKyNpbmNsdWRlIDxzdGRpby5oPgorI2luY2x1ZGUgPHN0ZGludC5o
PgorI2luY2x1ZGUgPGhleGFnb25fcHJvdG9zLmg+CisKK2ludCBlcnI7CisKKyNpbmNsdWRlICJo
ZXhfdGVzdC5oIgorCitzdGF0aWMgdm9pZCBjaGVja19pbnRlcmxlYXZlKHZvaWQpCit7CisgICAg
dWludDY0X3QgaW5wdXQ7CisgICAgdWludDY0X3QgaW50ZXI7CisgICAgdWludDY0X3QgZGVpbnRl
cjsKKworICAgIC8qCisgICAgICogaW50ZXJsZWF2ZSB0YWtlcyB0aGUgMzIgZXZlbiBiaXRzIGFu
ZCAzMiBvZGQgYml0cyBvZiBSc3MgYW5kCisgICAgICogaW50ZXJsZWF2ZXMgdGhlbTogZXZlblsw
XSBnb2VzIHRvIGJpdCAwLCBvZGRbMF0gdG8gYml0IDEsCisgICAgICogZXZlblsxXSB0byBiaXQg
Miwgb2RkWzFdIHRvIGJpdCAzLCBldGMuCisgICAgICoKKyAgICAgKiBJbnB1dDogIGxvdyAzMiBi
aXRzIChldmVuIGhhbGYpLCBoaWdoIDMyIGJpdHMgKG9kZCBoYWxmKQorICAgICAqIElmIGxvdyA9
IDB4RkZGRkZGRkYsIGhpZ2ggPSAweDAwMDAwMDAwOgorICAgICAqICAgcmVzdWx0IGhhcyBldmVy
eSBldmVuIGJpdCBzZXQsIGV2ZXJ5IG9kZCBiaXQgY2xlYXIKKyAgICAgKiAgID0gMHg1NTU1NTU1
NTU1NTU1NTU1CisgICAgICovCisgICAgaW5wdXQgPSAweDAwMDAwMDAwRkZGRkZGRkZVTEw7Cisg
ICAgaW50ZXIgPSBRNl9QX2ludGVybGVhdmVfUChpbnB1dCk7CisgICAgY2hlY2s2NChpbnRlciwg
MHg1NTU1NTU1NTU1NTU1NTU1VUxMKTsKKworICAgIC8qIEFsbCBvbmVzIHNob3VsZCBzdGF5IGFs
bCBvbmVzICovCisgICAgaW5wdXQgPSAweEZGRkZGRkZGRkZGRkZGRkZVTEw7CisgICAgaW50ZXIg
PSBRNl9QX2ludGVybGVhdmVfUChpbnB1dCk7CisgICAgY2hlY2s2NChpbnRlciwgMHhGRkZGRkZG
RkZGRkZGRkZGVUxMKTsKKworICAgIC8qIEFsbCB6ZXJvcyBzaG91bGQgc3RheSBhbGwgemVyb3Mg
Ki8KKyAgICBpbnB1dCA9IDB4MDAwMDAwMDAwMDAwMDAwMFVMTDsKKyAgICBpbnRlciA9IFE2X1Bf
aW50ZXJsZWF2ZV9QKGlucHV0KTsKKyAgICBjaGVjazY0KGludGVyLCAweDAwMDAwMDAwMDAwMDAw
MDBVTEwpOworCisgICAgLyoKKyAgICAgKiBkZWludGVybGVhdmUgaXMgdGhlIGludmVyc2Ugb2Yg
aW50ZXJsZWF2ZS4KKyAgICAgKiBkZWludGVybGVhdmUoaW50ZXJsZWF2ZSh4KSkgc2hvdWxkIGVx
dWFsIHguCisgICAgICovCisgICAgaW5wdXQgPSAweERFQURCRUVGQ0FGRUJBQkVVTEw7CisgICAg
aW50ZXIgPSBRNl9QX2ludGVybGVhdmVfUChpbnB1dCk7CisgICAgZGVpbnRlciA9IFE2X1BfZGVp
bnRlcmxlYXZlX1AoaW50ZXIpOworICAgIGNoZWNrNjQoZGVpbnRlciwgaW5wdXQpOworCisgICAg
LyogZGVpbnRlcmxlYXZlIG9mIDB4NTU1NS4uLjU1NTUgLT4gbG93IGhhbGYgYWxsIDFzLCBoaWdo
IGhhbGYgYWxsIDBzICovCisgICAgZGVpbnRlciA9IFE2X1BfZGVpbnRlcmxlYXZlX1AoMHg1NTU1
NTU1NTU1NTU1NTU1VUxMKTsKKyAgICBjaGVjazY0KGRlaW50ZXIsIDB4MDAwMDAwMDBGRkZGRkZG
RlVMTCk7Cit9CisKK3N0YXRpYyB2b2lkIGNoZWNrX2Nyb3VuZCh2b2lkKQoreworICAgIC8qCisg
ICAgICogY3JvdW5kKDB4MzAwLCAjOCkgLT4gMyAoZXhhY3Qgc2hpZnQsIG5vIHJvdW5kaW5nIG5l
ZWRlZCkuCisgICAgICogMHgzMDAgPj4gOCA9IDMKKyAgICAgKi8KKyAgICBjaGVjazMyKFE2X1Jf
Y3JvdW5kX1JJKDB4MzAwLCA4KSwgMyk7CisKKyAgICAvKgorICAgICAqIGNyb3VuZCgweDM4MCwg
IzgpIC0+IDQgKDB4MzgwID4+IDggPSAzLjUsIHJvdW5kcyB0byBldmVuID0gNCkKKyAgICAgKi8K
KyAgICBjaGVjazMyKFE2X1JfY3JvdW5kX1JJKDB4MzgwLCA4KSwgNCk7CisKKyAgICAvKgorICAg
ICAqIGNyb3VuZCgweDI4MCwgIzgpIC0+IDIgKDB4MjgwID4+IDggPSAyLjUsIHJvdW5kcyB0byBl
dmVuID0gMikKKyAgICAgKi8KKyAgICBjaGVjazMyKFE2X1JfY3JvdW5kX1JJKDB4MjgwLCA4KSwg
Mik7CisKKyAgICAvKgorICAgICAqIGNyb3VuZCgweDNDMCwgIzgpIC0+IDQgKDB4M0MwID4+IDgg
PSAzLjc1LCByb3VuZHMgdXAgdG8gNCkKKyAgICAgKi8KKyAgICBjaGVjazMyKFE2X1JfY3JvdW5k
X1JJKDB4M0MwLCA4KSwgNCk7CisKKyAgICAvKgorICAgICAqIFNoaWZ0IGJ5IDAgLT4gcmV0dXJu
IHRoZSBpbnB1dCB1bmNoYW5nZWQuCisgICAgICovCisgICAgY2hlY2szMihRNl9SX2Nyb3VuZF9S
SSg0MiwgMCksIDQyKTsKK30KKworaW50IG1haW4odm9pZCkKK3sKKyAgICBjaGVja19pbnRlcmxl
YXZlKCk7CisgICAgY2hlY2tfY3JvdW5kKCk7CisKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQ
QVNTIik7CisgICAgcmV0dXJuIGVyciA/IDEgOiAwOworfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNn
L2hleGFnb24vbWVzb24uYnVpbGQgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRl
eCBlMzAxN2RiMjRmNi4uNjkzNWQwMjgwMmIgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29u
L21lc29uLmJ1aWxkCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC02OSw2
ICs2OSw3IEBAIHRlc3RzICs9IHsKICAgJ3Rlc3RfYWJzLlMnOiB7J2NmbGFncyc6IGFzbWZsYWdz
fSwKICAgJ3Rlc3RfYml0Y250LlMnOiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfYml0
c3BsaXQuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAorICAndGVzdF9iaXRvcHMuYyc6IHsnY2Zs
YWdzJzogY2ZsYWdzfSwKICAgJ3Rlc3RfY2FsbC5TJzogeydjZmxhZ3MnOiBhc21mbGFnc30sCiAg
ICd0ZXN0X2Nsb2JiZXIuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAogICAndGVzdF9jbXAuUyc6
IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAotLSAKMi4zNC4xCgo=

