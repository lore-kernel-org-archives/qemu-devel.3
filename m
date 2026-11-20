Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D29606B201
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I6W4BmAI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QzcPZdBx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTEN-00069p-Dn; Fri, 20 Nov 2026 13:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTEE-00062Z-Rp
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTEC-0000q1-MH
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:54 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfG302039943
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rFR9IveaGEdOSwUhmBMq9AQdusj381LWePfz/bin8Ic=; b=I6W4BmAIDqONYD7d
 uCGeSXmWgOMXmnLsvGRcu5v4vozR93u4C7afr/nSiW8TPprNWVpojPeUkQLnpx2v
 mSIw1OgpS/UfS0aSctD1meKKLgTevAhElDb9lRM9P63evzxWhvVNY90+DOKq0Fbd
 aiq1hzpCqGFs86vMMWLFWF37e/r28p0ubwaQ++kzPrGZlF9frOsk4Bzdiok32BKd
 bV2SkdnOMwN5pfBPGvWNMsrihgKaT48BehB3YqdTpXlHENy5j3padOJyyXUe1ymg
 KN/nJ98Kse0iPaTMDV3JL4AQmkCzde9ebIr1UoekdK3y+5ed5JHrRpwvHD3pQXdG
 sqsUzg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjtub1t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:51 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-862a2ece202so1370600a34.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 10:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795198851; x=1795803651; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rFR9IveaGEdOSwUhmBMq9AQdusj381LWePfz/bin8Ic=;
 b=QzcPZdBxmwZlmESjsW9ugy7KdnazIONeBs6KLpjRBAWY8DJpHc4PCcZVVlOgFsoqN1
 etk+cg8lysDsNY7FKXJbxM/CwbOu02m6zgnc1LrZepYLq+jzSuo42ccnsyCh2jPxn3hq
 +YO4Ezd8xHTtriCfOlmDgcNdI7woz9INURMKbOssMYCPdDzvgWwnI/0VH/10+r3OJJSc
 dDLaTMQfWSU3Ujo5JErf2KWIe2XuzXO+WBQYVYDN/Z0UzeIw1Af7WJav3e4cA0PyjUpX
 oHqzfJn4C5xUU40NK0IJPCVhJX1vonVF+sB6uqNFIWIHNDFX1fsD+IhT8aXn1rCZV1VM
 u7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198851; x=1795803651;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rFR9IveaGEdOSwUhmBMq9AQdusj381LWePfz/bin8Ic=;
 b=Y8G95SwxtK/LWfg3JtiTBcoMM3qMajGmi+T4j0scy10hXeNKvHiSasDx05inUXu4Yg
 Ht+DHwOOMPO1KS5wAQpbpGBx4elACHMKgIwEVlfYfuJwCYWv2IYqIELa91+wBr/U6r34
 bfTV3GqdOxTVIBJpsvd/SQGyFAegh/F65U8dkcW1R640hWEaZvS+d3nwdIqodZhEglhj
 dQ7zr3BNx2epvr3FSOBZgQVjUrWoHpJHRROXbUd5KTOc+2siRoG6A6e8c1cxZHmfZ6Nn
 cGDG+rTdkzMv/WR18LB6bjviegJmmi+8onwzWjkYDETpDeSzEQHM53azWuHVVrVkKJb0
 TkEg==
X-Gm-Message-State: APuU4Z/5wY6U0n7yKmByG2zd0zi/gMrO7MJFND/FjiBs9fVSRiPVFwJ6
 Yyw9JGPFBhTEZsQTvAqKhAgxo9sVZVEsUKizsSYaba9m/AFxXUBPXjgeSzxr8rzqCS+dGufBMEP
 w9ejbo6W2d84tu4MNdv8ThAqsrUJeZiDkaBZr497Wf5CrZHOkcr7CBnZWkj7C05t0jA==
X-Gm-Gg: AYBFou2iqgTKRyQOE6KU44gtpYQeX74TtEBE6bILj4teqqhP1es0mRKllbq6wXP9mnw
 V32DAkOw9gdUNx4wHZm2oJ5sXE7gWhc7S9gxxfo0do9CF9jX1e2C4x2NaQ3sjbDz3fYT8YJekb9
 4PGWROR8oE3gxDeYp+fRZFpSkggsu5+2oY6d4oztT9ECBl8gdJOlzXW+WIACAb8VYSOFQRNW5X1
 BiMdhxcBROBqyh8+/+p8d7QM/C25te0cqxIw9cYPpunzlCl3iMxVoGqVC3L/58ZcsBpQKwypD9m
 BhgX2q9djdchFYzurQ7Ms5juZ5jGAUe/dJobwS4YM7bJiFXG8kKfpQ7maRphpsLZyGWSY4cWd+l
 zUsPCvcqrkWTquzMb/h27RTr1/zKEJXb7N4qc8C60wUHqea0r9598ACERCCRFRZBA/ayYUcquDj
 qwHfQDkDpgEDAhQv6RFpQUGQ==
X-Received: by 2002:a05:6830:2708:b0:862:c4ae:7fca with SMTP id
 46e09a7af769-86315a09772mr4753624a34.26.1795198850739; 
 Fri, 20 Nov 2026 10:20:50 -0800 (PST)
X-Received: by 2002:a05:6830:2708:b0:862:c4ae:7fca with SMTP id
 46e09a7af769-86315a09772mr4753582a34.26.1795198850240; 
 Fri, 20 Nov 2026 10:20:50 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631690fd36sm2698364a34.20.2026.11.20.10.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:20:48 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.2 v2 11/12] hw/hexagon: honor configured RAM backends
Date: Fri, 20 Nov 2026 10:20:30 -0800
Message-Id: <20261120182031.560481-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: JTDfUxzIK6f4RoqvITejFp4dBIuolt2_
X-Proofpoint-GUID: JTDfUxzIK6f4RoqvITejFp4dBIuolt2_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MiBTYWx0ZWRfX5VS1p7i+dhiT
 d2hojMHEPVKMb9x/YzxG9DzI1/kCRJg3ayVSfj6RRyecNnzRmR0nQOb22tphvOADCB/ZKhfkG8u
 VYgEgOrFOBY+inpUzSVoI6ZR1tBL9ZEBWTalAGmGPl6dhnZka/GdHr9VLWR+csudWLzLSFveL5O
 q50nplbAJp/6wWS0ToPV+7liHpm4oon1ZESnXSALdy3xvdg6S37PKUtEKNnnSF61TN+aqDPiHcA
 UBLVt4L2wP8rvm5/mlHp4L2CUYynKSkqJgq3zwrXzld0QFTEEwaRBKd7L6mw270S3kRztrOd8u6
 b9Mz6Ubi/xMt7l8H5KEvHfoUlGU6UOAac0dfg1fcsu0UNIOVatTnhrQmDFEalMyUJbnRZTBRWW6
 OxidoHJBWE1P3MwDhNOOElQ7P8ZX86XgUSVXnGr7s/zEmKPbSDPmDOI2/SHEHTohTafcmVIzBlL
 egIYnG3PNvL3pL0kWBQ==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b008f83 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=CClahisu4qSzJabnEcAA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MiBTYWx0ZWRfX9EMo7k+bB88F
 vM9doRnxw13r7xMyOUsUvb/klsC2RHb9fOENHRxotv5naZtlglbuL1Ls66cvUNA/1SqKPe+Ajx1
 06U0IUCuPzgwjxHFnNqdztG2O1Hgucg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200072
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

VGhlIEhleGFnb24gbWFjaGluZXMgY29uc3VtZWQgdGhlIE1hY2hpbmVTdGF0ZSBtZW1vcnktYmFj
a2VuZApjb25maWd1cmF0aW9uIGJ1dCBhbHdheXMgY3JlYXRlZCBhbmQgbWFwcGVkIGEgc2VwYXJh
dGUgRERSIHJlZ2lvbiwgc28KYSBtZW1vcnkgYmFja2VuZCBnaXZlbiB3aXRoIC1tYWNoaW5lIG1l
bW9yeS1iYWNrZW5kPSB3YXMgbmV2ZXIgdXNlZCBhcwpndWVzdCBtZW1vcnkuICBNYXAgdGhlIG1h
Y2hpbmUncyBjb25maWd1cmVkIFJBTSB3aGVuIHByZXNlbnQsIHNvIHRoYXQKZmlsZS1iYWNrZWQg
YW5kIHNoYXJlZCBtZW1vcnkgKGFzIHVzZWQgYnkgdGhlIG1pZ3JhdGlvbiB0ZXN0cykgaXMKYWN0
dWFsbHkgZ3Vlc3QgbWVtb3J5LiAgS2VlcCB0aGUgYm9hcmQtYWxsb2NhdGVkIFJBTSBhcyB0aGUg
ZmFsbGJhY2suCgpBZGQgYSByZWdyZXNzaW9uIHRlc3QgdGhhdCB3cml0ZXMgZ3Vlc3QgRERSIGFu
ZCB2ZXJpZmllcyB0aGUgYnl0ZXMKdGhyb3VnaCB0aGUgYmFja2luZyBmaWxlLiAgSXQgZmFpbHMg
d2l0aG91dCB0aGlzIGNoYW5nZS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleC1zdWJzeXMuYyAgICAgICAg
ICAgfCAxMCArKysrKysrLS0tCiB0ZXN0cy9xdGVzdC9oZXhhZ29uLWNvbmZpZy10ZXN0LmMgfCAy
NiArKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4LXN1YnN5
cy5jIGIvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKaW5kZXggNTJlYzBjYWRhY2MuLjExMDNkMmI1
NTZjIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYworKysgYi9ody9oZXhhZ29u
L2hleC1zdWJzeXMuYwpAQCAtMTYzLDEyICsxNjMsMTYgQEAgdm9pZCBoZXhfc3Vic3lzX2NyZWF0
ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsCiB7CiAgICAgTWFjaGluZVN0YXRlICpt
YWNoaW5lID0gTUFDSElORShobXMpOwogICAgIE1lbW9yeVJlZ2lvbiAqc3lzbWVtID0gZ2V0X3N5
c3RlbV9tZW1vcnkoKTsKKyAgICBNZW1vcnlSZWdpb24gKnJhbSA9IG1hY2hpbmUtPnJhbTsKICAg
ICBzaXplX3QgaTsKIAogICAgIC8qIE1haW4gRERSLiAqLwotICAgIG1lbW9yeV9yZWdpb25faW5p
dF9yYW0oJmhtcy0+cmFtLCBOVUxMLCAiZGRyLnJhbSIsIG1hY2hpbmUtPnJhbV9zaXplLAotICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2ZhdGFsKTsKLSAgICBtZW1vcnlfcmVnaW9u
X2FkZF9zdWJyZWdpb24oc3lzbWVtLCBtX2NmZy0+ZGRyX2Jhc2UsICZobXMtPnJhbSk7CisgICAg
aWYgKCFyYW0pIHsKKyAgICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmaG1zLT5yYW0sIE5V
TEwsICJkZHIucmFtIiwgbWFjaGluZS0+cmFtX3NpemUsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJmVycm9yX2ZhdGFsKTsKKyAgICAgICAgcmFtID0gJmhtcy0+cmFtOworICAgIH0K
KyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oc3lzbWVtLCBtX2NmZy0+ZGRyX2Jhc2Us
IHJhbSk7CiAKICAgICAvKiBDb25maWctdGFibGUgUk9NIGFuZCB0aGUgYmxvYiB0aGF0IGJhY2tz
IGl0LiAqLwogICAgIG1lbW9yeV9yZWdpb25faW5pdF9yb20oJmhtcy0+Y2ZndGFibGVfcm9tLCBO
VUxMLCAiY29uZmlnX3RhYmxlLnJvbSIsCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9oZXhhZ29u
LWNvbmZpZy10ZXN0LmMgYi90ZXN0cy9xdGVzdC9oZXhhZ29uLWNvbmZpZy10ZXN0LmMKaW5kZXgg
OTU1NGZjZTU3Y2EuLmQ0ZGM5YTJkM2YwIDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9oZXhhZ29u
LWNvbmZpZy10ZXN0LmMKKysrIGIvdGVzdHMvcXRlc3QvaGV4YWdvbi1jb25maWctdGVzdC5jCkBA
IC02MCw2ICs2MCwzMSBAQCBzdGF0aWMgdm9pZCB0ZXN0X2NvbmZpZ190YWJsZShnY29uc3Rwb2lu
dGVyIGRhdGEpCiAgICAgcXRlc3RfZW5kKCk7CiB9CiAKKy8qIFRoZSB2aXJ0IG1hY2hpbmUgbWFw
cyBERFIgYXQgZ3Vlc3QgcGh5c2ljYWwgYWRkcmVzcyAwLiAqLworc3RhdGljIHZvaWQgdGVzdF9t
ZW1vcnlfYmFja2VuZCh2b2lkKQoreworICAgIGdfYXV0b2ZyZWUgY2hhciAqcGF0aCA9IE5VTEw7
CisgICAgZ19hdXRvZnJlZSBjaGFyICphcmdzID0gTlVMTDsKKyAgICBjb25zdCB1aW50OF90IGV4
cGVjdGVkW10gPSB7IDB4MTIsIDB4MzQsIDB4NTYsIDB4NzggfTsKKyAgICB1aW50OF90IGFjdHVh
bFs0XTsKKyAgICBpbnQgZmQgPSBnX2ZpbGVfb3Blbl90bXAoImhleGFnb24tcmFtLVhYWFhYWCIs
ICZwYXRoLCBOVUxMKTsKKworICAgIGdfYXNzZXJ0X2NtcGludChmZCwgPj0sIDApOworICAgIGdf
YXNzZXJ0X2NtcGludChmdHJ1bmNhdGUoZmQsIDE2ICogMTAyNCAqIDEwMjQpLCA9PSwgMCk7Cisg
ICAgYXJncyA9IGdfc3RyZHVwX3ByaW50ZigiLW1hY2hpbmUgdmlydCxtZW1vcnktYmFja2VuZD1y
YW0gLW0gMTZNICIKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICItb2JqZWN0IG1lbW9yeS1i
YWNrZW5kLWZpbGUsaWQ9cmFtLHNpemU9MTZNLCIKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJzaGFyZT1vbixtZW0tcGF0aD0lcyIsIHBhdGgpOworICAgIHF0ZXN0X3N0YXJ0KGFyZ3MpOwor
ICAgIC8qIFFFTVUgaGFzIHRoZSBmaWxlIG9wZW4gbm93LCBzbyBub3RoaW5nIGlzIGxlZnQgYmVo
aW5kIG9uIGZhaWx1cmUuICovCisgICAgdW5saW5rKHBhdGgpOworICAgIHdyaXRlbCgweDEwMDAs
IDB4Nzg1NjM0MTIpOworICAgIGdfYXNzZXJ0X2NtcGludChsc2VlayhmZCwgMHgxMDAwLCBTRUVL
X1NFVCksID09LCAweDEwMDApOworICAgIGdfYXNzZXJ0X2NtcGludChyZWFkKGZkLCBhY3R1YWws
IHNpemVvZihhY3R1YWwpKSwgPT0sIHNpemVvZihhY3R1YWwpKTsKKyAgICBnX2Fzc2VydF9jbXBt
ZW0oYWN0dWFsLCBzaXplb2YoYWN0dWFsKSwgZXhwZWN0ZWQsIHNpemVvZihleHBlY3RlZCkpOwor
ICAgIHF0ZXN0X2VuZCgpOworICAgIGNsb3NlKGZkKTsKK30KKwogaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKiphcmd2KQogewogICAgIHNpemVfdCBpOwpAQCAtNzQsNSArOTksNiBAQCBpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAgICAgICAgIHF0ZXN0X2FkZF9kYXRhX2Z1bmMocGF0
aCwgbWMsIHRlc3RfY29uZmlnX3RhYmxlKTsKICAgICB9CiAKKyAgICBxdGVzdF9hZGRfZnVuYygi
L2NvbmZpZy9tZW1vcnktYmFja2VuZCIsIHRlc3RfbWVtb3J5X2JhY2tlbmQpOwogICAgIHJldHVy
biBnX3Rlc3RfcnVuKCk7CiB9Ci0tIAoyLjM0LjEKCg==

