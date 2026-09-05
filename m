Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B98C79F91
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqe-0002xx-FR; Sat, 05 Sep 2026 14:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqb-0002wN-6M
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqY-0001if-MU
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:36 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbmTR2981054
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w1m5T3pie2PcZksprgQWN7g7lG21NsYd40SmK6+IXlQ=; b=GUV75erUkvAzdlen
 M21ijqPV7ecgjlwXa2uYC1j37annGcUOGpD9XXfqyGeRkl7nI98vJ+zo583vb7+o
 y2+QqE4yctce0muXsGDW6TwV0IktXNDGudeQiW0F7j0Yq9m4k6batIt9y8T07Jau
 EZxWaSl7t1bMFyYdnNo1LB1gpoc3q9XpGEpgrQDLLQYnhwRb37P6ArY48DWcKGkO
 s57+ipyzzDOZhpo0edAbcxt6NKyPzrwqVoWmyp22s2dgg4v6BmIsqU0ABfuyxToU
 yUNA9eFKC0/1RZZHCYr7iKX7sUtK2CCs4YaeSe74aQPNBRC51W+AVluVEwe47OQL
 /MuVNw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg8eq2f9j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39aee9b4cf2so3182462a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631833; x=1789236633; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w1m5T3pie2PcZksprgQWN7g7lG21NsYd40SmK6+IXlQ=;
 b=N0pZbwTWy2ZAxFlj6TqAydNf/f/kQlnzzr1owjVD0GNUykRI+rdQz9WoRQNdHtyXcn
 DnGIsyQUYLt+X6Iun2C+S2FIb9S/hXMsvh7eNd//oYw/2uafXMH2QbRAgWoNFHNMK+PG
 YQCjmGjC6IZWg/pmrD8U1tNBhQjteOIyO0VpdcDdp7JcEadPqA8c1H6YY47WYvyHZWNv
 g1pBYhox03RsEpRnba/zseiUq1nFJ1yEWEcsjyARVNDsvXWOoW7T0AZ+ZYH5/COdD4Ew
 pJey/6p6DFycP6E9zy9IYg2mCrPMgHxrdIQ201Wax6yIDekW0K7B+J7QQCaZKYEWtaZq
 bB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631833; x=1789236633;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w1m5T3pie2PcZksprgQWN7g7lG21NsYd40SmK6+IXlQ=;
 b=JEqywWf8TYqcd9m+j6nt6sgnMQULhORmReYwDpCCa7d2S9HXqnD/KNruZQ07FgiwN1
 DaljZ7Q8ZnJta7NPY3eH6jfNIAw/M90qHfaVb5aLFhhXzwqiCjbPLho63xnDiAJfupiY
 8iiMTlol9CKEc2pDxWfPE9oOCAVtoRAg9G2gy0VRrT5D/VYPIQjEteCpcOmxNrMiEGk5
 wnlEhGr+rtfgMV8d8X/HqI6TpPDxoRiDVZ7jIjBJoyDToYi6YPqpE1o1T2BnRoPo8sCc
 qR/cNDcINoyv7oKxQEnn+3p8rqblcFq74FyOnI6UruTxY9U1WHCmEwSMxhN0NR4xDwnV
 8ubw==
X-Gm-Message-State: AFuF++kgIXo/xMHr+MR769g8gAI1/wuf+IZJZQMcYlsu0HhkmXtkIB5y
 mgDWg1MquP8LxMktTUhzNO5O2/mCLkYlk39o4NLe18uW76INziW/SikckMVnN/iGqqziOzvJ9nx
 x6lDS4MSg1aXuX5wDOPoon6HPsjomWapeob08gVHpBe7Zb2+Bl76ohcwUYur5fqRISA==
X-Gm-Gg: AYBFou2v7bpN5/lfFtioFBWWnPd9xfUm6QvLNEDmv1uL6T8048KPjBJM/Xb0my5KWu+
 NhtZASUWEOIP2GgSm05ndidDZaf6Uf+4l/OYe0gmLiNRT8Pjk4Tk3rEdakm3Bcli/UKQFVSqjWq
 OsWp9+90m0EkSdEqMtQ1rdnqul1uMQtoZ4NGq/RFdAvlqxfoYuSe0Abtps8lq98/9KfSKvHUR8k
 7GpAYxdOLeqDyKhOvtakc0iV08H1XSQFcare6SlKwE49z61Xbd2Ur4aavHARLL7XerJMVk3skxo
 SWUcj6NNTuz9eLI09rmOr086pUbeUaIVnBanvv0MMgTXoVeG6MDw3rAxzK8bqazW/ULqVIUC9T+
 kDw6zimYYe5ZmRUW0tf4KBp9mA73aPnr5RcitYDgll+Hs4nP8
X-Received: by 2002:a17:90b:1d45:b0:398:9bd4:d1a with SMTP id
 98e67ed59e1d1-39b262995b8mr20376984a91.25.1788631832557; 
 Sat, 05 Sep 2026 11:10:32 -0700 (PDT)
X-Received: by 2002:a17:90b:1d45:b0:398:9bd4:d1a with SMTP id
 98e67ed59e1d1-39b262995b8mr20376931a91.25.1788631832091; 
 Sat, 05 Sep 2026 11:10:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:10:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 15/17] tests/tcg/hexagon: add rounding conv, sffma:lib,
 and sfinvsqrta
Date: Sat,  5 Sep 2026 11:09:47 -0700
Message-Id: <20260905180949.1852673-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=F61nsKhN c=1 sm=1 tr=0 ts=6a9c5b19 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Yw4lSlXxLJphHwZ-g9MA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfXzzLeKAnzYyqe
 bie1UkSMzkTBFnICGlaNdkRBK7HLrsnPXMBdyeXPKVeM/P3trDd9FC47ZpChOCdrXv7kph24wMr
 WoQqgFTpM0UBzKwKAZHb+j9Le4vU2Io=
X-Proofpoint-ORIG-GUID: OgfIeNAEkk6OCPWjAfgvK5a9PgPy5nfT
X-Proofpoint-GUID: OgfIeNAEkk6OCPWjAfgvK5a9PgPy5nfT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX2w5XhBe56v7M
 /ZAudAufb1uUm+cmbYDdUfhlyaEp7A3yT3MjK7wY+fIgRNICfcoHx5lCxGnucaKuk5WxuteYGkh
 7BErWoIygue/Yv4ETYMDn8+VmzbCh5yAJQN0PlHWMm2mpsYoRJErapQ5C+DTy0gBNdNTvLJm6QS
 7XBrqpfPztf9oEtCvm+nSOljDSRSRrcsCZfTFC05NSddFMjjEFhenDRkYNff64NBs6pDCrtDn2c
 eTwt1TuVryHGTbLvY+w4/CRlnldgVES89NMgEAUsyIURvTanJ0B1UNbXmE10YIDP77LOkzeLDWw
 xOGff/oMzZtKtQX3HS+6ConjOOXJioBIw6K3i4TbPXSCx/vKNgfp0mgsDt3RTYNghKBEiQfIjY6
 rnBmKxk4fLx0iVhBSz8THaxOCgH8I+UWRa70K6vsdV/oEP8ekpvBiWzYS0KDoWQMCV0Kbc2AFDm
 rt4LrD/xlOYgQztQXlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050201
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

QWRkIHJvdW5kLXRvLW5lYXJlc3QgZmxvYXQtdG8taW50IGNvbnZlcnNpb24gdGVzdHMgZm9yIHRo
ZSBub24tOmNob3AgdmFyaWFudHMsCnNmbXB5OmxpYiB3aXRoIEluZi1JbmYgdG8gdmVyaWZ5IGV4
Y2VwdGlvbiBzdXBwcmVzc2lvbiwgYW5kIHNmaW52c3FydGEKd2l0aCBhIGRlbm9ybWFsIGlucHV0
LgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2Zwc3R1ZmYuYyB8IDk5ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5OSBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIGIvdGVzdHMvdGNnL2hleGFn
b24vZnBzdHVmZi5jCmluZGV4IDBmMjhhMjE4ZDg0Li45ZWE3OWM2MTdkOSAxMDA2NDQKLS0tIGEv
dGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2Zwc3R1
ZmYuYwpAQCAtMTAxNyw2ICsxMDE3LDEwMiBAQCBzdGF0aWMgdm9pZCBjaGVja19kZm1weWhoKHZv
aWQpCiAgICAgY2hlY2s2NF9uZShkZl9leHAocmVzdWx0KSwgMHg3RkYwMDAwMDAwMDAwMDAwVUxM
KTsKIH0KIAorLyoKKyAqIFJvdW5kLXRvLW5lYXJlc3QgZmxvYXQtdG8taW50IGNvbnZlcnNpb25z
IHdpdGggbm9ybWFsIHZhbHVlcy4KKyAqIFRoZXNlIHRlc3QgdGhlIG5vbi06Y2hvcCB2YXJpYW50
cyB3aGljaCB1c2UgdGhlIFVTUiByb3VuZGluZyBtb2RlLgorICovCitzdGF0aWMgdm9pZCBjaGVj
a19jb252X3JuZCh2b2lkKQoreworICAgIHVpbnQzMl90IHJlczMyOworICAgIHVpbnQ2NF90IHJl
czY0OworCisgICAgLyogY29udmVydF9zZjJ3KDEuNSkgcm91bmRzIHRvIG5lYXJlc3QtZXZlbiA9
IDIgKi8KKyAgICBhc20oQ0xFQVJfRlBTVEFUVVMKKyAgICAgICAgIiVbcmVzXSA9IGNvbnZlcnRf
c2YydyglW3ZhbF0pXG5cdCIKKyAgICAgICAgOiBbcmVzXSAiPXIiKHJlczMyKQorICAgICAgICA6
IFt2YWxdICJyIigweDNmYzAwMDAwKSAgICAvKiAxLjVmICovCisgICAgICAgIDogInIyIiwgInVz
ciIpOworICAgIGNoZWNrMzIocmVzMzIsIDIpOworCisgICAgLyogY29udmVydF9zZjJkKDEuNSkg
PSAyICovCisgICAgYXNtKENMRUFSX0ZQU1RBVFVTCisgICAgICAgICIlW3Jlc10gPSBjb252ZXJ0
X3NmMmQoJVt2YWxdKVxuXHQiCisgICAgICAgIDogW3Jlc10gIj1yIihyZXM2NCkKKyAgICAgICAg
OiBbdmFsXSAiciIoMHgzZmMwMDAwMCkgICAgLyogMS41ZiAqLworICAgICAgICA6ICJyMiIsICJ1
c3IiKTsKKyAgICBjaGVjazY0KHJlczY0LCAyVUxMKTsKKworICAgIC8qIGNvbnZlcnRfZGYydygx
LjUpID0gMiAqLworICAgIGFzbShDTEVBUl9GUFNUQVRVUworICAgICAgICAiJVtyZXNdID0gY29u
dmVydF9kZjJ3KCVbdmFsXSlcblx0IgorICAgICAgICA6IFtyZXNdICI9ciIocmVzMzIpCisgICAg
ICAgIDogW3ZhbF0gInIiKDB4M0ZGODAwMDAwMDAwMDAwMFVMTCkgICAgLyogMS41ICovCisgICAg
ICAgIDogInIyIiwgInVzciIpOworICAgIGNoZWNrMzIocmVzMzIsIDIpOworCisgICAgLyogY29u
dmVydF9kZjJkKDEuNSkgPSAyICovCisgICAgYXNtKENMRUFSX0ZQU1RBVFVTCisgICAgICAgICIl
W3Jlc10gPSBjb252ZXJ0X2RmMmQoJVt2YWxdKVxuXHQiCisgICAgICAgIDogW3Jlc10gIj1yIihy
ZXM2NCkKKyAgICAgICAgOiBbdmFsXSAiciIoMHgzRkY4MDAwMDAwMDAwMDAwVUxMKSAgICAvKiAx
LjUgKi8KKyAgICAgICAgOiAicjIiLCAidXNyIik7CisgICAgY2hlY2s2NChyZXM2NCwgMlVMTCk7
Cit9CisKKy8qCisgKiBUZXN0IHNmbXB5OmxpYiB3aXRoIEluZi1JbmYuCisgKgorICogUnggKz0g
c2ZtcHkoUnMsIFJ0KTpsaWIgd2l0aCBSeCA9IC1JbmYsIFJzKlJ0IC0+ICtJbmYKKyAqIEluZiAt
IEluZiBpcyBpbnZhbGlkLCBidXQgdGhlIDpsaWIgdmFyaWFudCBzdXBwcmVzc2VzIHRoZQorICog
ZXhjZXB0aW9uIGFuZCByZXR1cm5zIHplcm8uCisgKi8KK3N0YXRpYyB2b2lkIGNoZWNrX3NmZm1h
X2xpYl9pbmYodm9pZCkKK3sKKyAgICB1aW50MzJfdCByZXN1bHQ7CisKKyAgICAvKiArSW5mICs9
IHNmbXB5KCtJbmYsIDEuMCk6bGliIC0+IEluZiAobm8gZXhjZXB0aW9uLCBub3JtYWwpICovCisg
ICAgcmVzdWx0ID0gU0ZfSU5GOworICAgIGFzbShDTEVBUl9GUFNUQVRVUworICAgICAgICAiJVty
ZXNdICs9IHNmbXB5KCVbYV0sICVbYl0pOmxpYlxuXHQiCisgICAgICAgIDogW3Jlc10gIityIihy
ZXN1bHQpCisgICAgICAgIDogW2FdICJyIihTRl9JTkYpLCBbYl0gInIiKFNGX29uZSkKKyAgICAg
ICAgOiAicjIiLCAidXNyIik7CisgICAgY2hlY2szMihyZXN1bHQsIFNGX0lORik7CisKKyAgICAv
KgorICAgICAqIC1JbmYgKz0gc2ZtcHkoK0luZiwgMS4wKTpsaWIgLT4gSW5mIC0gSW5mID0gaW52
YWxpZAorICAgICAqIFRoZSA6bGliIHZhcmlhbnQgc2hvdWxkIHJldHVybiB6ZXJvIGZvciBJbmYg
LSBJbmYuCisgICAgICovCisgICAgcmVzdWx0ID0gU0ZfSU5GIHwgKDF1IDw8IDMxKTsgICAgLyog
LUluZiAqLworICAgIGFzbShDTEVBUl9GUFNUQVRVUworICAgICAgICAiJVtyZXNdICs9IHNmbXB5
KCVbYV0sICVbYl0pOmxpYlxuXHQiCisgICAgICAgIDogW3Jlc10gIityIihyZXN1bHQpCisgICAg
ICAgIDogW2FdICJyIihTRl9JTkYpLCBbYl0gInIiKFNGX29uZSkKKyAgICAgICAgOiAicjIiLCAi
dXNyIik7CisgICAgY2hlY2szMihyZXN1bHQsIDApOworfQorCisvKgorICogVGVzdCBzZmludnNx
cnRhIHdpdGggYSBkZW5vcm1hbCBpbnB1dC4KKyAqLworc3RhdGljIHZvaWQgY2hlY2tfaW52c3Fy
dGFfZGVub3JtKHZvaWQpCit7CisgICAgdWludDMyX3QgcmVzdWx0OworICAgIHVpbnQzMl90IHBy
ZWR2YWw7CisgICAgdWludDMyX3QgZXhwX2JpdHM7CisKKyAgICAvKiBEZW5vcm1hbCBwb3NpdGl2
ZSBmbG9hdDogMHgwMDQwMDAwMCAoc21hbGwgZGVub3JtKSAqLworICAgIGFzbSB2b2xhdGlsZSgi
JVtyZXNdLHAwID0gc2ZpbnZzcXJ0YSglW3ZhbF0pXG5cdCIKKyAgICAgICAgICAgICAgICAgIiVb
cHJlZF0gPSBwMFxuXHQiCisgICAgICAgICAgICAgICAgIDogW3Jlc10gIj1yIihyZXN1bHQpLCBb
cHJlZF0gIj1yIihwcmVkdmFsKQorICAgICAgICAgICAgICAgICA6IFt2YWxdICJyIihTRl9kZW5v
cm0pCisgICAgICAgICAgICAgICAgIDogInAwIik7CisgICAgLyogUmVzdWx0IHNob3VsZCBiZSBh
IHZhbGlkIGZsb2F0IChub3QgTmFOL3plcm8pICovCisgICAgY2hlY2szMl9uZShyZXN1bHQsIDAp
OworICAgIGV4cF9iaXRzID0gKHJlc3VsdCA+PiAyMykgJiAweGZmOworICAgIGNoZWNrMzJfbmUo
ZXhwX2JpdHMsIDB4ZmYpOyAgLyogbm90IEluZi9OYU4gKi8KK30KKwogaW50IG1haW4oKQogewog
ICAgIGNoZWNrX2NvbXBhcmVfZXhjZXB0aW9uKCk7CkBAIC0xMDM4LDYgKzExMzQsOSBAQCBpbnQg
bWFpbigpCiAgICAgY2hlY2tfY29udl91ZDJkZigpOwogICAgIGNoZWNrX2RmbXB5Zml4KCk7CiAg
ICAgY2hlY2tfZGZtcHloaCgpOworICAgIGNoZWNrX2NvbnZfcm5kKCk7CisgICAgY2hlY2tfc2Zm
bWFfbGliX2luZigpOworICAgIGNoZWNrX2ludnNxcnRhX2Rlbm9ybSgpOwogCiAgICAgcHV0cyhl
cnIgPyAiRkFJTCIgOiAiUEFTUyIpOwogICAgIHJldHVybiBlcnIgPyAxIDogMDsKLS0gCjIuMzQu
MQoK

