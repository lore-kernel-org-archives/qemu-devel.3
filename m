Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A143C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 17:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toQWg-0003Db-4t; Sat, 01 Mar 2025 12:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWY-0003BM-BE
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:21:14 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWR-0008SV-WA
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:21:13 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213J6v1015653
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 17:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pSwTbZf0rhHgEbo8zKq7Sa8B/wzbDH7ANNE+bmuVwT0=; b=DPJDlc43HnP/EH1F
 DRTb9C2a7sA+NT31iY1u2geFfxHTwfq+1RLF6+kisCyaFoX9rLReQlhftpC3B8EI
 2mESQXKgZzXyyZut3Ls8TbQ6ypka1pYv7zzR5g6aK8lkun9Tzq4zt8MLr2o5RwL3
 0STtjrRTeqjdnY5Y9XFrcwtez1Adb4N96TMUPHxSZyBObTZ38gJjNPVVjbpYtYBF
 2RSHYO2IgYK7CjIDjiLu4tjG1kGi485Ex/8mCj53Bhtkt3TDoUdAfcwEUqU1zUvG
 bOoi7cHeQqMqCUJW7wrykqhjREXXJ4mx/xDD2OT9mIvjhAa13ZDkmU3m7UyuweL+
 FoKslQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hs4nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 17:21:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22368a8979cso30697065ad.2
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 09:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740849663; x=1741454463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSwTbZf0rhHgEbo8zKq7Sa8B/wzbDH7ANNE+bmuVwT0=;
 b=M4lq3wLtEPH/VemcCCghC1fOwqVJ1LZSyFLZ3Q86k2Z6ZbbsVNLF1r1IgbFmVul4VH
 0dpz8q/SfqIaPajp9TdnSp0MF6f+ucJFteXkqKh7yQtjFSQZLFADzCbqAUCAFJb+pqJO
 MHtDsPrgogR6pGVsreH8ZCINmZJmmtXkRd+j3wzH/7DdIX53m058SQdpexmq36pOHfW0
 rgJJAL8a51L9R2VTCZZ0Ax4pYLCVZ957MwfweoMyxkinxEVfR6xv84t81g6eYKph5XWj
 svWiShisYzlfVi3WPkr5mvvMyOOIahl0RJVDQV7qBOxE3pRthfyCalZqw+0sChkWKY4M
 2SWg==
X-Gm-Message-State: AOJu0YzId/3ggcJp9fplnICgItX+vYncThLHiKaTZrzUORB/qwFhFh6i
 iXpgy3p/E9O3VmU3nZ6HNr9ddz3uEaVCClQnMXDVaOPqyOfZ51WdvZHcGE+VTBSGAgiXif2WsY5
 e2nUBLLMSeQhgxJaWQoLulU3weMJcNCDon5O0Av0gZOFJTv2U0VMUDh4hqNbXiw==
X-Gm-Gg: ASbGnctQkNwTYeGz1f9vfQCOzfSWHKi35bdwNmSWSeRCAjPCdp6jTCi39uytP9EEp3P
 bqLobsSiovHfofcOBkFCI6j6uCpZhBnuhOXNxq5DwDqeEZWwd47iEkUbAPffV/gb5yk/9gONv7d
 +RpP5fZG8WsGoeMpwMoyCRXlYiUdAdIyoVJOTOVRoZ8A3kiwre/gd/P2P2sZxbWVHq6qzWywOV2
 xc0NSGMZ814OIKGbrMF+T2kgPvVsAo4bTSNummVUqxkpcxVRz/LKIi7LUu4qkE1hjdEiTeLkzpu
 0M1hpWCsAkfOIGaMQZqRYSbcIm9ySW4Sg4l9xf5L1ocO37zS/Jg5eiOrwyhfeclX
X-Received: by 2002:a17:902:e54a:b0:220:bdf2:e51e with SMTP id
 d9443c01a7336-22368fa90cbmr126264955ad.26.1740849663532; 
 Sat, 01 Mar 2025 09:21:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaxTMHsMYf/wfY47PfNo/kkqGKEmg+qYppWt1opTxXmd3cePcWkq0gHHw/apXqLTQvTdPEyA==
X-Received: by 2002:a17:902:e54a:b0:220:bdf2:e51e with SMTP id
 d9443c01a7336-22368fa90cbmr126264715ad.26.1740849663155; 
 Sat, 01 Mar 2025 09:21:03 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9dacsm51308275ad.83.2025.03.01.09.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 09:21:02 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 8/8] tests/functional: Add a hexagon minivm test
Date: Sat,  1 Mar 2025 09:20:45 -0800
Message-Id: <20250301172045.1295412-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: GeYj8E_07dvagkenMnPljsxNv7brsZtP
X-Proofpoint-ORIG-GUID: GeYj8E_07dvagkenMnPljsxNv7brsZtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_07,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogTUFJTlRBSU5FUlMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwogdGVzdHMvZnVuY3Rpb25hbC9tZXNvbi5i
dWlsZCAgICAgICAgICAgIHwgIDggKysrKysKIHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9oZXhhZ29u
X21pbml2bS5weSB8IDQyICsrKysrKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdl
ZCwgNTEgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL2Z1bmN0aW9uYWwv
dGVzdF9oZXhhZ29uX21pbml2bS5weQoKZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRB
SU5FUlMKaW5kZXggZGVlYjc4NzhjOC4uNDhhNWU3YzAwNSAxMDA2NDQKLS0tIGEvTUFJTlRBSU5F
UlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTI0Nyw2ICsyNDcsNyBAQCBGOiBnZGIteG1sL2hleGFn
b24qLnhtbAogRjogZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CiBGOiBkb2NzL2RldmVs
L2hleGFnb24tc3lzLnJzdAogRjogZG9jcy9kZXZlbC9oZXhhZ29uLWwydmljLnJzdAorRjogdGVz
dHMvZnVuY3Rpb25hbC90ZXN0X2hleGFnb25fbWluaXZtLnB5CiBUOiBnaXQgaHR0cHM6Ly9naXRo
dWIuY29tL3F1aWMvcWVtdS5naXQgaGV4LW5leHQKIAogSGV4YWdvbiBpZGVmLXBhcnNlcgpkaWZm
IC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9tZXNvbi5idWlsZCBiL3Rlc3RzL2Z1bmN0aW9uYWwv
bWVzb24uYnVpbGQKaW5kZXggMTExZDhiYWIyNi4uNzhiNDJlNThmOSAxMDA2NDQKLS0tIGEvdGVz
dHMvZnVuY3Rpb25hbC9tZXNvbi5idWlsZAorKysgYi90ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1
aWxkCkBAIC0xMzUsNiArMTM1LDE0IEBAIHRlc3RzX2kzODZfc3lzdGVtX3F1aWNrID0gWwogICAn
bWlncmF0aW9uJywKIF0KIAordGVzdF90aW1lb3V0cyArPSB7CisgICdoZXhhZ29uX21pbml2bSc6
IDE4MCwKK30KKwordGVzdHNfaGV4YWdvbl9zeXN0ZW1fcXVpY2sgPSBbCisgICdoZXhhZ29uX21p
bml2bScsCitdCisKIHRlc3RzX2kzODZfc3lzdGVtX3Rob3JvdWdoID0gWwogICAnaTM4Nl90dXhy
dW4nLAogXQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2hleGFnb25fbWluaXZt
LnB5IGIvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2hleGFnb25fbWluaXZtLnB5Cm5ldyBmaWxlIG1v
ZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAwMDAuLjJiYTkyYmNjZTMKLS0tIC9kZXYvbnVsbAorKysg
Yi90ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfaGV4YWdvbl9taW5pdm0ucHkKQEAgLTAsMCArMSw0MiBA
QAorIyEvdXNyL2Jpbi9lbnYgcHl0aG9uMworIworIyBDb3B5cmlnaHQoYykgMjAyNC0yMDI1IFF1
YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisjCisj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisKK2ltcG9ydCBvcwor
ZnJvbSBnbG9iIGltcG9ydCBnbG9iCitmcm9tIHFlbXVfdGVzdCBpbXBvcnQgUWVtdVN5c3RlbVRl
c3QsIEFzc2V0Citmcm9tIHFlbXVfdGVzdCBpbXBvcnQgd2FpdF9mb3JfY29uc29sZV9wYXR0ZXJu
CisKK2NsYXNzIE1pbmlWTVRlc3QoUWVtdVN5c3RlbVRlc3QpOgorCisgICAgdGltZW91dCA9IDE4
MAorICAgIEdVRVNUX0VOVFJZID0gMHhjMDAwMDAwMAorCisgICAgUkVQTyA9ICdodHRwczovL2Fy
dGlmYWN0cy5jb2RlbGluYXJvLm9yZy9hcnRpZmFjdG9yeScKKyAgICBBU1NFVF9UQVJCQUxMID0g
XAorICAgICAgICBBc3NldChmJ3tSRVBPfS9jb2RlbGluYXJvLXRvb2xjaGFpbi1mb3ItaGV4YWdv
bi8nCisgICAgICAgICAgICAgICAnMTkuMS41L2hleGFnb25fbWluaXZtXzIwMjRfRGVjXzE1LnRh
ci5neicsCisgICAgICAgICdkNzkyMGI1ZmYxNGJlZDVhMTBiMjNhZGE3ZDRlYjkyN2VkZTA4NjM1
MjgxZjI1MDY3ZTBkNTcxMWZlZWUyYzJhJykKKworICAgIGRlZiB0ZXN0X21pbml2bShzZWxmKToK
KyAgICAgICAgc2VsZi5zZXRfbWFjaGluZSgndmlydCcpCisgICAgICAgIHNlbGYuYXJjaGl2ZV9l
eHRyYWN0KHNlbGYuQVNTRVRfVEFSQkFMTCkKKyAgICAgICAgcm9vdGZzX3BhdGggPSBmJ3tzZWxm
LndvcmtkaXJ9L2hleGFnb24tdW5rbm93bi1saW51eC1tdXNsLXJvb3RmcycKKyAgICAgICAga2Vy
bmVsX3BhdGggPSBmJ3tyb290ZnNfcGF0aH0vYm9vdC9taW5pdm0nCisKKyAgICAgICAgYXNzZXJ0
KG9zLnBhdGguZXhpc3RzKGtlcm5lbF9wYXRoKSkKKyAgICAgICAgZm9yIHRlc3RfYmluX3BhdGgg
aW4gZ2xvYihmJ3tyb290ZnNfcGF0aH0vYm9vdC90ZXN0XyonKToKKyAgICAgICAgICAgIHByaW50
KGYnIyBUZXN0aW5nICJ7b3MucGF0aC5iYXNlbmFtZSh0ZXN0X2Jpbl9wYXRoKX0iJykKKworICAg
ICAgICAgICAgdm0gPSBzZWxmLmdldF92bSgpCisgICAgICAgICAgICB2bS5hZGRfYXJncygnLWtl
cm5lbCcsIGtlcm5lbF9wYXRoLAorICAgICAgICAgICAgICAgICAgJy1kZXZpY2UnLAorICAgICAg
ICAgICAgICAgICAgZidsb2FkZXIsYWRkcj17aGV4KHNlbGYuR1VFU1RfRU5UUlkpfSxmaWxlPXt0
ZXN0X2Jpbl9wYXRofScpCisgICAgICAgICAgICB2bS5sYXVuY2goKQorICAgICAgICAgICAgdm0u
d2FpdCgpCisgICAgICAgICAgICBzZWxmLmFzc2VydEVxdWFsKHZtLmV4aXRjb2RlKCksIDApCisK
K2lmIF9fbmFtZV9fID09ICdfX21haW5fXyc6CisgICAgUWVtdVN5c3RlbVRlc3QubWFpbigpCi0t
IAoyLjM0LjEKCg==

