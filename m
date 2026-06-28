Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09656C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 19:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdund-00021m-Cf; Sun, 28 Jun 2026 15:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wdunb-00021G-L3
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 15:04:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wduna-0001Lt-6O
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 15:04:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SHihH8410904
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 19:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/LgVM4OZvGWowdk4e+y6Yg
 BT1A7YtMf7lAvJ57GjJv8=; b=VYS4ifBoTeUxBunsO38xJCF+Ug8YipybGJGbsG
 H6nb3+J+5ZyLF5GkraJVFVZjK7csU4PSK2QySSGNdV0Q7WvpIFcDZi25fh0zNZxQ
 1bKSszZm3ZPCpyd1Cw5lxBNGg44WSxgtj3gvJXG5XAFsoCBAQRpQR+xw2DVG6bOJ
 NkXHvO0uRe40wZvSuDPPri3e/XhhE51mRzmc8mu12uV3W9iDkO3Kcj3ZBmhdG/XF
 97s4GBy5ncIMrfhRyNW9BCK55niN2zLZ9BvQQAoF7CsnebujCC4TW7/rB4ehCIrd
 uxdAwHlmRcYSKN8OGs1RBbLZgo/Crsh0umKM+Ro1iVLkwk4g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26w6kg6e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 19:04:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so5752250eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782673445; x=1783278245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/LgVM4OZvGWowdk4e+y6YgBT1A7YtMf7lAvJ57GjJv8=;
 b=RMFZQ9i1hyN4FsHd9Cnh6sJrusJkm78uuOd/DDL3SMiD6oMiOvwTbCB5fiU/shmRhk
 yxzi89F1u07Isq6Ulu6akg3FMG4GbqHLfDCdhFqZQUjRexCqrs+BprIowp+4sQPGVd3o
 ICDwedD52rPuT+IXMqPe74AicQslKhNfHseINsKy4tIf+pHuQvjqALHF5s0YOd9Z9CwS
 ogOxs4r+mZKWOExFIehk1Dhcc35CfN/6071taF4fbW2AC/HklWaPUf5Qo4pDl13kuQj0
 JU3HAmgzEz7FRbY7kH3atdpA+mbKeZ+px98MX81KfIyqZ4h6uSXOONHH8AiPG4QIdoNG
 Kwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782673445; x=1783278245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LgVM4OZvGWowdk4e+y6YgBT1A7YtMf7lAvJ57GjJv8=;
 b=LKIFszTUhJPcMF5AfMOzRwcHdKySw9z7JOupDY+EE0uMef04usR1yzwXLQfkZdbGbY
 msZYmRmb4ePZXHxhI8HWiEo9GWNt+moUTpHUYUgal+9gC2BxrH4b8L6amY+RPAHtS1GP
 GU8lz+Ao6cZqpG718GRWwBg/YsrH3UzFgfCkTm8B5QKugEV7mJ+t5WURHyAVmKj55cH+
 1471JUZZ4euVSsvEt5Ra0fc7tYSIWFV+hrTBpiwDxvjtMY5SbmgivDtw8t4tBUIJJSak
 EBUqksQLpwtbemcopS4vAlhCmdE0HmmBFRVAWw2r38G7aCwOwcMqp5b6D4jEm+mR2B+A
 tAyQ==
X-Gm-Message-State: AOJu0Yx7OWlrxxyP2N07Z6gDsZF2vBaC4fD9BPiLH9JU4mNftkNdanue
 4ccL6A42azXQJYVSbCgS2oqM/Vs/8coj3/sNUmxkmDOa9W1GNOzR7FBPgvIqIjo8dpkLxWfoiU7
 SeACjzauN0T6LtelD4SNDiEjK/5rt4hFWr4ZuxwOywhKvMK4CeFGvIU5xwxiuyu0NKw==
X-Gm-Gg: AfdE7cnhSo3SlFJWMcEWlMNtjAIA4iQOtd3j8b5Z/O/terrfAk4sj9UfAHIst3dRwg5
 0cxhjNCJ1NRNzrzw5p4pU/vzJa42cyUz1C94skr0Ne8KKo3Xge6qzJOXCxENkJ7xcb6vAT1APC5
 6EL6VAGGk+a+z5HLF9PqfB3FXTBxkTXgTjDObwLRxO9CqhasTBzR15m+4WYtmkrikVDv85aT4M0
 I5Rqf0yI6R0oEu22yyDWcmoGjBmM0wSvd7n1B81vKKQFeDNjRl2kw4RYr0o92cqEb/CaHxsQahi
 NHxBgqCf+BcjRkDTmAb0fz3WP/62k0rGPH2CFDdtTgRyYzIpEFkvKhFMLkUZuIlRkshHBI2OlCl
 rfu4Tgv+NnzXa4QL+VHHWNkEf9BckaMT1Va3865Vulkqdc5boHG71rTNvsIw=
X-Received: by 2002:a05:7022:6298:b0:139:f3cd:22a2 with SMTP id
 a92af1059eb24-139f3cd251cmr4314495c88.44.1782673440531; 
 Sun, 28 Jun 2026 12:04:00 -0700 (PDT)
X-Received: by 2002:a05:7022:6298:b0:139:f3cd:22a2 with SMTP id
 a92af1059eb24-139f3cd251cmr4314476c88.44.1782673439931; 
 Sun, 28 Jun 2026 12:03:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f77602sm34335379c88.8.2026.06.28.12.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 12:03:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 pierrick.bouvier@oss.qualcomm.com, stefanha@redhat.com,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] configs/meson: disable hexagon idef-parser for emscripten
 builds
Date: Sun, 28 Jun 2026 12:03:58 -0700
Message-Id: <20260628190358.634435-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 1biaRcNpx6ru9OwlEOefh3uWkuMTGyZg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE3MSBTYWx0ZWRfX3sbgxarYh0OP
 zCX1FYphWxKxGrUs6h50mEvxE8cCUJvpjytcSPW+Tp696v8F1VRuK0oVBKk6AQR1j7YIjK9Nwxs
 DqxeZ2jVMKk76nlu9umw8ClmLyZ10MM=
X-Proofpoint-GUID: 1biaRcNpx6ru9OwlEOefh3uWkuMTGyZg
X-Authority-Analysis: v=2.4 cv=SuugLvO0 c=1 sm=1 tr=0 ts=6a417026 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=MPO-fdqQ5Q6WhVTBZRsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE3MSBTYWx0ZWRfX9DvsxftFNsmO
 DRR7x754gjQ2tdEBMAoEWE2jPFiWewgLfXFO7Jz/sa9ndY97RWiSAz3kPZf0shsai/S92dA822b
 ZcszpEcGa08Noh2+GmrRLcFhjrIDUkVMTPDX0Fu37OiHkNGEZjbHCoC88pk2J8kToe3XcgeZM6y
 EaNb3MdFFeCpsBZwjqD47wQycHwPuylHEfVBtXeXAg5yA2S9+qXrhchWKa2u1I7BjzViQR+h+8j
 3ldWNAxcK+lcJf9Ctl+4fNe2NodOP4+UJRwJD5Z5UkfiChcPdhOzS4W6kHcbRSYxLS+8vwiOVa8
 tTCuayM+rl0D1dOJouIVX/El8sSmMGp33M6GMGF04jveEdOeP2v/OiDsBlORpruuMboFf1Wsmrn
 gL/MnPvlCM72v4Pr1rLMq5CB5p243lLivHkfgPa/b4Wb0uFHB9yxjfHTLR/V3c8MJSW9iAzLAlW
 ydreTb/DzImkIeSbk0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280171
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

VGhlIGlkZWYtcGFyc2VyIGlzIGEgbmF0aXZlIGJ1aWxkIHRvb2wgdGhhdCByZXF1aXJlcyBnbGli
LTIuMCBvbiB0aGUKYnVpbGQgbWFjaGluZS4gSW4gZW1zY3JpcHRlbiBjcm9zcyBidWlsZHMsIGVt
Y29uZmlndXJlIHNldHMKUEtHX0NPTkZJR19MSUJESVIgdG8gZW1zY3JpcHRlbidzIHN5c3Jvb3Qg
d2hpY2ggcHJldmVudHMgbmF0aXZlCnBrZy1jb25maWcgZnJvbSBmaW5kaW5nIHN5c3RlbS1pbnN0
YWxsZWQgcGFja2FnZXMuIERpc2FibGUgaWRlZi1wYXJzZXIKYnkgZGVmYXVsdCBmb3IgZW1zY3Jp
cHRlbiBzaW5jZSB0aGUgd2FzbSB0YXJnZXQgZG9lcyBub3QgbmVlZCBpdC4KClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBjb25maWdz
L21lc29uL2Vtc2NyaXB0ZW4udHh0IHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9jb25maWdzL21lc29uL2Vtc2NyaXB0ZW4udHh0IGIvY29uZmln
cy9tZXNvbi9lbXNjcmlwdGVuLnR4dAppbmRleCA0MjMwZTg4MDA1Zi4uYzVjNTdlMzkyYTkgMTAw
NjQ0Ci0tLSBhL2NvbmZpZ3MvbWVzb24vZW1zY3JpcHRlbi50eHQKKysrIGIvY29uZmlncy9tZXNv
bi9lbXNjcmlwdGVuLnR4dApAQCAtNiwzICs2LDYgQEAgb2JqY19hcmdzID0gWyctcHRocmVhZCdd
CiAjIGNvbmZpZ3VyYXRpb24gc28gZXhwbGljaXRseSBhZGQgdGhlIGZsYWcgaGVyZS4KIGNfbGlu
a19hcmdzID0gWyctcHRocmVhZCcsJy1zQVNZTkNJRlk9MScsJy1zUFJPWFlfVE9fUFRIUkVBRD0x
JywnLXNGT1JDRV9GSUxFU1lTVEVNJywnLXNBTExPV19UQUJMRV9HUk9XVEgnLCctc1RPVEFMX01F
TU9SWT0yR0InLCctc1dBU01fQklHSU5UJywnLXNFWFBPUlRfRVM2PTEnLCctc0FTWU5DSUZZX0lN
UE9SVFM9ZmZpX2NhbGxfanMnLCctc0VYUE9SVEVEX1JVTlRJTUVfTUVUSE9EUz1hZGRGdW5jdGlv
bixyZW1vdmVGdW5jdGlvbixUVFksRlMnXQogY3BwX2xpbmtfYXJncyA9IFsnLXB0aHJlYWQnLCct
c0FTWU5DSUZZPTEnLCctc1BST1hZX1RPX1BUSFJFQUQ9MScsJy1zRk9SQ0VfRklMRVNZU1RFTScs
Jy1zQUxMT1dfVEFCTEVfR1JPV1RIJywnLXNUT1RBTF9NRU1PUlk9MkdCJywnLXNXQVNNX0JJR0lO
VCcsJy1zRVhQT1JUX0VTNj0xJywnLXNBU1lOQ0lGWV9JTVBPUlRTPWZmaV9jYWxsX2pzJywnLXNF
WFBPUlRFRF9SVU5USU1FX01FVEhPRFM9YWRkRnVuY3Rpb24scmVtb3ZlRnVuY3Rpb24sVFRZLEZT
J10KKworW3Byb2plY3Qgb3B0aW9uc10KK2hleGFnb25faWRlZl9wYXJzZXIgPSBmYWxzZQotLSAK
Mi4zNC4xCgo=

