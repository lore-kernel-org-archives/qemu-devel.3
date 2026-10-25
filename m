Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587A606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mq3fEo75;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FgCHmRFC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKpKC-0007Nr-8U; Sat, 24 Oct 2026 23:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKpK9-0007Na-7j
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:55:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKpK7-0003tU-MG
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:55:08 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P18RDv3099806
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=; b=Mq3fEo75BTfGV9DJ
 jQeaGrggO4CWsdsZ1w4wn5ggybCUCBh0JBhumZWNKovQGOE72P0uTYZN3jMzOdmI
 7MdSV+zgQZynYrktztuWIsAGy7Xu/OBOkwJ+WqwMzuVNYsUWRghtWYLeolL32e0/
 sjQE+5oDCp71dijeEGIHlc+XyJAypWnS5jZM/M46kCjif0SzoRmPThHSzVzhzaSf
 OiA47Si/5zf6OZWwUyxZcAdKvyJ5XrRpyBPuC+1Hw1HB/q7666/hsr5hltg+ETr3
 1dDlgG7InjDzWFJ2pQc3zAeZIKY5nvTU9qWmPIP29KFdubTF7fcFolLikra+NVGj
 /GFD0w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgj1paqec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:55:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so5624084eec.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792900504; x=1793505304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=;
 b=FgCHmRFC47IOWCJnrtwPuB6D/P4dgaaAkxO1R4JO6lVwDFGTSCTiTdEG93x5vOw1L4
 ExhkPZKWbq2R2BJIytJ81ICYPlkxOyj64pdhz9BrTbdNoUzSvhVzcbDDCi0xUX5qAC/s
 Trlho0rJFrFN/WOeIpcUaYjqB7qrSVcpS1XnmoOlsdYqBy5TRQkhWbxC6smQJTH5vbpF
 F4bMOri5vXBr9xUEBjFnCO1z0H8HEzKbgub+xCwmgc+scq5wTM3clfRUbCWfVYIAlp0N
 uby+SBxVhQcArA2yDvCsgs6lCjLA1Q81Y8Yr3yVKwx2HOIeJl/cVjkJPLU1J8ynt7hp5
 /rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900504; x=1793505304;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=;
 b=dFZ+3fKVt68ibyNUQOLDpAZzFob5z8vdAyAdzi5+7OagQV0WyEemme4uA8PQDkkcdE
 mQJM6ndlvqACzwsqKMmCRSBuT4mnE8cEi508qaIZbzZpfN/Fp+teNbNOUJKdBXtapFIX
 hLj7v0fpf82sp90b3VM5nyNdDsZ/ogCrXG5NjYWjbjE/Pb92RPuZfa/sWgUKqKbhm+OF
 64nrtEctNs6E5oQ67aoosCMYP84EWZMJ+VLs6FMRWAVctZW4XAXNuRUC9C8N2lpvuJ6T
 a04JQcbpBpQhcYp2vKTq38EVueTAp8nz/Y9DEEEacacI6PILH3EjNGUqkVfpk3J8j/wM
 r6HA==
X-Gm-Message-State: AFq9FYJIiNmA0KJY0Ka/w9beEKxtI9KoW7AQEBqWQt4io3kAzP+9B9Ad
 WhJUdWiQCLbRkRGXMYGbpfF4Kq/0YRzal0cbyzSM1Z0G1gtl+9gKH+Gi1zy55w+L3O6qrLF8Ath
 NIt3ZjrOIq1nwr3aZYLw9D5/cTwlS0TA5nC9gxils1VcVv8VNskIBIm/MTJPQollIFA==
X-Gm-Gg: AYBFou2TXKkJC51zpW0pyUeZtC1aZpkGB9sl2egTdAU3nyCfJHetBhIdewOIpXoaijh
 wZfcqd9z8v8Dgl14EUnJXaSu+PPkTX8XNMqZdnLaTBatFsRd0KyjZmc3Y2QIoJxApC17/Xej+My
 wwEs2ZTZEbp8vDRtiBZHl06UzoKwnH9x5bENN0r26gCDucLQ9vckzNiPekIwTKgFsu7rUSOrss+
 gNhpcHToljNXYIkrRifsJ49w4quV2mMW/EH7+F2sBeII3fqWGefnjp50zkTcrRg2UO4wuaJ4nde
 olibePYKsVHjbW5lQGsee0aWngfWbuuOQyAjE9gJuWzRbBL/kLgbenj50ez4AbF9oKelhfgPXFO
 Wmn7MtY5LsbfJ+0x6K0etdyNbbWpqn5yY+ePynDAD+QAIzmU=
X-Received: by 2002:a05:693c:87dc:10b0:35a:22a4:12a with SMTP id
 5a478bee46e88-369e845e70bmr5015842eec.18.1792900503463; 
 Sat, 24 Oct 2026 20:55:03 -0700 (PDT)
X-Received: by 2002:a05:693c:87dc:10b0:35a:22a4:12a with SMTP id
 5a478bee46e88-369e845e70bmr5015815eec.18.1792900502827; 
 Sat, 24 Oct 2026 20:55:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ee72c0sm18366774eec.29.2026.10.24.20.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:55:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 40/40] hw/intc/hex-l2vic: find the next pending irq a word
 at a time
Date: Sat, 24 Oct 2026 20:23:46 -0700
Message-Id: <20261025032346.2917451-41-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxNSBTYWx0ZWRfXxOULpjlAip7F
 /dbMhfmVCllIt2pXYmVwZwIP/hr/EQzfJxNx4iGgoGZa05lEE6RWS5WmSeFBiqlzdTa/1/LYYCq
 /MR7GI5M5Iy6DCBla4rTm7J+ouzXToQ=
X-Proofpoint-GUID: wZYFKWbDmUR6ou7v3sSfwB_Y2xQ6s6MQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxNSBTYWx0ZWRfX2Va+QZDVWk3z
 zuXtyUGHMQ4YFogoqC2IhpK3VFe3L1uggdehPloBf8EM9VsIKloE2hzPnzgcq5DCTzckircN3wW
 jNi+YCjHpztyeGuinepqnhjj+YqqtI0qvJlhsiWl4UhvAuOoJk0nrLQQn+QDCk6/yq9MS8vWxiS
 7g2IuGlvcbiCGC46AvQ2UWYWYHvF5/DDKBPj0/gnV9wWApdzt3Ez7gN6cvs8gmjQRGVDHN6UW2k
 NYGUII39OTpaz3SyNpAcH8NQFN+g+tjfxy2H4z9/zT9k8p+QZXO7ad5ufyL0qdyAg/TwBFsJ01T
 4kX+qJA/feeHvfjd3qpUm7eoc0qqPcGS8CFlXI4hZaAzT1WQ9Y+HQQ3O+o/8VnZn98PbBZeYMsF
 sSeK8sdGcpx3cmUYTQ5EV4brOQEdOWCLbSASE2p+jR+ryaDHB20rX4aKf9wgsVP96rdw6cbfT3g
 g3Q9Z7Aph28YQVNGJdw==
X-Proofpoint-ORIG-GUID: wZYFKWbDmUR6ou7v3sSfwB_Y2xQ6s6MQ
X-Authority-Analysis: v=2.4 cv=D5vSufRj c=1 sm=1 tr=0 ts=6add7d98 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=8fQjqy5ARp1ca2tc:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=XWoxCBOuUWUKfCXQB-IA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250015
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

bDJ2aWNfdXBkYXRlX2FsbCgpIGNhbGxlZCBsMnZpY191cGRhdGUoKSBmb3IgZWFjaCBvZiB0aGUg
MTAyNCBpcnFzLCBhbmQKZXZlcnkgY2FsbCByZXNjYW5uZWQgYWxsIG9mIGludF9zdGF0dXMgZm9y
IGFuIGFjdGl2ZSB2aWQuICBjaWFkIHJ1bnMgaXQKb24gZWFjaCBpbnRlcnJ1cHQgcmV0dXJuLCBz
byB0aGlzIHdhcyBhIGhvdCBmdW5jdGlvbiBmb3IgYW4gT1MgYm9vdC4KCkNoZWNrIG9uY2Ugd2hl
dGhlciBhIHZpZCBpcyBhY3RpdmUsIHRoZW4gZGVsaXZlciB0aGUgbG93ZXN0IGlycSB0aGF0IGlz
CmJvdGggcGVuZGluZyBhbmQgZW5hYmxlZCBieSBzY2FubmluZyBpbnRfcGVuZGluZyAmIGludF9l
bmFibGUgYSB3b3JkIGF0CmEgdGltZS4gIFRoZSBkZWxpdmVyZWQgaXJxIGlzIHVuY2hhbmdlZC4K
ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBody9pbnRjL2hleC1sMnZpYy5jIHwgMTcgKysrKysrKysrKysrKystLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2h3L2ludGMvaGV4LWwydmljLmMgYi9ody9pbnRjL2hleC1sMnZpYy5jCmluZGV4IGI3
M2VjYjgyMWU0Li4yMzM1MjM2ZjgzNyAxMDA2NDQKLS0tIGEvaHcvaW50Yy9oZXgtbDJ2aWMuYwor
KysgYi9ody9pbnRjL2hleC1sMnZpYy5jCkBAIC0yOTAsOSArMjkwLDIwIEBAIHN0YXRpYyBib29s
IGwydmljX3VwZGF0ZShIZXhMMlZJQ1N0YXRlICpzLCBpbnQgaXJxKQogCiBzdGF0aWMgdm9pZCBs
MnZpY191cGRhdGVfYWxsKEhleEwyVklDU3RhdGUgKnMpCiB7Ci0gICAgZm9yIChpbnQgaSA9IDA7
IGkgPCBMMlZJQ19JTlRFUlJVUFRfTUFYOyBpKyspIHsKLSAgICAgICAgaWYgKGwydmljX3VwZGF0
ZShzLCBpKSkgewotICAgICAgICAgICAgLyogb25jZSB2aWQgaXMgYWN0aXZlLCBuby1vbmUgZWxz
ZSBjYW4gc2V0IGl0IHVudGlsIGNpYWQgKi8KKyAgICAvKiBvbmNlIHZpZCBpcyBhY3RpdmUsIG5v
LW9uZSBlbHNlIGNhbiBzZXQgaXQgdW50aWwgY2lhZCAqLworICAgIGlmICh2aWRfYWN0aXZlKHMp
KSB7CisgICAgICAgIHJldHVybjsKKyAgICB9CisKKyAgICAvKgorICAgICAqIFF1aWNrbHkgZmlu
ZCBsb3dlc3QtbnVtYmVyZWQgaXJxIHJlYWR5IGJ5IHNjYW5uaW5nIHRoZWlyIHN0YXR1c2VzCisg
ICAgICogcmFuZ2UgYnkgcmFuZ2UgaW5zdGVhZCBvZiBvbmUgYnkgb25lLgorICAgICAqLworICAg
IGZvciAoaW50IHNsaWNlID0gMDsgc2xpY2UgPCBTTElDRV9NQVg7IHNsaWNlKyspIHsKKyAgICAg
ICAgdWludDMyX3QgcmVhZHkgPSBzLT5pbnRfcGVuZGluZ1tzbGljZV0gJiBzLT5pbnRfZW5hYmxl
W3NsaWNlXTsKKworICAgICAgICBpZiAocmVhZHkpIHsKKyAgICAgICAgICAgIGwydmljX3VwZGF0
ZShzLCBzbGljZSAqIDMyICsgY3R6MzIocmVhZHkpKTsKICAgICAgICAgICAgIHJldHVybjsKICAg
ICAgICAgfQogICAgIH0KLS0gCjIuMzQuMQoK

