Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6212BC79F9E
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2wYc-0006og-Gj; Sat, 05 Sep 2026 16:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2wYZ-0006jz-51
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:00:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2wYX-000570-Bi
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:00:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbJU22296020
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=a+CBXDO4Pm2yaldDRatlLKjTbgDEs6+OwEBymI4oKm8=; b=dg
 a++8zgWGDR1RGW4rARVj3jjGES1e1xyVVbmb6ARRfCdtiJX0Ly4D4nnltgcxprGK
 Z/ZfhZVOq/SYyM58qllNx4/pn5vnC3TkaEYMevf9WjoEHC3RMEXJLLiZ6iJyB0Fa
 AfT6BGvZS0GmRijTKQtMl8vYR7OBtAPmMyn2LEYYAl7jrF/3F3sPdLniWKUHfHZT
 HVndcL10A88bk5cusrSD/EaXzsuMOqvnPwH6VMW/nbH5VbDGcJZlk8scpyVn1VUR
 Kqjw/SeF2tktg4NhmAz1Lr0HvCsOtt2dC1ybj64l0mNFQ0aQWkaEkfVCmxjywRJQ
 IGIwng+xMQZpV9M66w/w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggcca1xg0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:00:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1c18c775eso3549704a12.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638403; x=1789243203; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=a+CBXDO4Pm2yaldDRatlLKjTbgDEs6+OwEBymI4oKm8=;
 b=cyuIvr+48wiKBJoYLB3kBapboujXsfHjLQ91dOkysblwAaIoW4wjK8tNqzyb1C45CR
 Vp4a/eD9+4ET+VbAN+Yvk+ZJt8PWcMBRz7DqOu4GRhzSg/4iJhvGBdZZg/bVg1TY8mAL
 stxzE9w8/TznkHZu9TKjcniAhy9iGiXPea9kZX7V1gpW5OCg4R2hNJRAML7b1aoFK4x/
 7NABV82QAQWL7xSgn/9c3MMGHYh8+3kcLPI8UWyHha5DEZuiIQRxYkZe0grTxStnqgSO
 CnqOQagGnql4kFCBtcWq1IiAfG1j4E9633OAbYA2fPDW02X7SEXonhYOWnO/DlP9bDOe
 AJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638403; x=1789243203;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a+CBXDO4Pm2yaldDRatlLKjTbgDEs6+OwEBymI4oKm8=;
 b=j+LIRBpsKZZM4+FnYla/3Ao/A5mt6thBd/K2sncNMSEUtK6a6sBhgjamJl8vCqZp2Y
 tp8WE7lMEM6OqLQIM34N7o3xsNH6cuYEFfFbFv82IYw3Z6N0dGw8k++A+qG5WSUXu8+2
 WbI5ribuAxTHcmXs3pUtfebQi05IaE/+/D1hnWrFX73DTi99WUkggkR8du8PgPl1aBOQ
 DuAF6fe19S8bS64WIytot/tyNz0aH0Wo+RViVlOYKeiRQYL4MhbDl5MqQUYkWckw4Xd4
 VO8hG8GxJ7iA1+mF47w7fjld3YHDKnj/xrP104ZtqEJgh9k4iTjc1g4+HwJlBcaligBD
 HGPg==
X-Gm-Message-State: AFuF++mDfx6z9HR+vJl8JpR+xVnYHR2nu+lZDe9mvdqNNqsVZURuuUFz
 vbo68Fh6nmNF50fsbPxYkBsOCUMhlbp+ntC2gE2iZt0KxKrrFzeA7XLh3h6PpOIrFEkQaT0ixu4
 OQwPMt3Bo5827udYOwQRNmLVGHXHiMwFSMt3RH+Mr5Tx4g7t2HaLBoJO2txjzb+cHoA==
X-Gm-Gg: AYBFou1EZOZqfVtnm17ubsbqDDr1zXQW8vMvTzAL7k4BXiZcVPc4H4nyNwJPqApS3D4
 JiWnD9BOfeqMBCnpWPxgaTa1MeFi3L7MVSMJLl0+AOpKtt5SJRlW53gb+eVRPVZQ6ssHDkwsmNb
 SeVGFTvapgiCJgvmiLCZaBm/LeFjYzRhE8GfdDlcWmX0Rs+1rE1K92Ck6zISv39iwB5J9yxXJ8v
 ICig+5KGbhmirtgJmiSjBL0kLJkXwtkIzs3yeyDTbhSRPrNZX6xn1c1dJAxF/arnpk2lex+Jg2L
 PRLSQPys26ohN10zd4eFuE6zcILrvmVjaOGNQoaHYYclw/Iv3CCgsb8NevuqUWC45CJlvy3uD3v
 FGWpyrHebSI+t4i0w25LgWsCsHtkQRA6oTz4+6vcUm95jM1TC
X-Received: by 2002:a17:903:198e:b0:2d7:5da6:2af4 with SMTP id
 d9443c01a7336-2dafaee6769mr217481285ad.4.1788638403273; 
 Sat, 05 Sep 2026 13:00:03 -0700 (PDT)
X-Received: by 2002:a17:903:198e:b0:2d7:5da6:2af4 with SMTP id
 d9443c01a7336-2dafaee6769mr217481135ad.4.1788638402858; 
 Sat, 05 Sep 2026 13:00:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3342af0bc08sm14316431eec.17.2026.09.05.13.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 13:00:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: [PATCH v4 4/6] target/hexagon: fix HVX predicate save size for
 histogram ops
Date: Sat,  5 Sep 2026 12:59:53 -0700
Message-Id: <20260905195955.2001304-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905195955.2001304-1-brian.cain@oss.qualcomm.com>
References: <20260905195955.2001304-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 2ja8J8BC3akU7YfefnVKBUs0bRuxMXlI
X-Authority-Analysis: v=2.4 cv=EJo2FVZC c=1 sm=1 tr=0 ts=6a9c74c3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=iBrAFeRkQMIbT85dZ3EA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 2ja8J8BC3akU7YfefnVKBUs0bRuxMXlI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMiBTYWx0ZWRfX4AoNpHJhMnox
 51jkdJdgUt14CbdXAd1k2xp8oXxuAS3KwdgnRnDL05RgdGniaXIP5+i01Sw0QqzP/Wi4E1HeyQM
 Vyc7qomvQPtXNV4TZYw1SsjDEi+jeyGlqwambAhWEG7ALgUe/MycDVhitV9tQV7sJDZ7yxUREYl
 m1xcCx4gNUwDgr6tVXv1rTYc2DDd4ZdteEtnB1EH3Ht3CuNgd6CIQZAObiC7+07/Imi5WgUa9Ii
 BtkK2nK7YizoZw0uRoplsoOj4FLOfvb8E92ekgiQzJ2ryDDb+NZEcnoloj7WsiYf1Ed8LJuBcbJ
 2jKhZVNgIiE8ftF5VwU5P2aZglxxGlclqmYR5ZpWudKIV+E7nXcMYeK4LNN0A2nFd8/sR5FZVy9
 sjlGd1t47aaAhGMkpccFy+S63tS2prtN8I1aQWrov6IiPI1wa5BrS9STiMa3HeTP75oLYsfkA1T
 8qVnCfdPTzT2Q4+rP3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMiBTYWx0ZWRfX+csgTJC1x/C0
 Rrvc9CvjaUN22s+LnXvzzwi8tZ527vAKdSsC+9k1yxB6j7AxbHjraDG7PqyGurJU+1TNoQIUb/v
 4tmetHyYv0oTrbJ1zLvGDVgu/q2ALMw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050222
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

VGhlIG1hc2tlZCBoaXN0b2dyYW0gaW5zdHJ1Y3Rpb25zIHNhdmUgdGhlIHByZWRpY2F0ZSBvcGVy
YW5kIHRvIHRoZSBxdG1wCnRlbXBvcmFyeSB3aXRoIGEgZ3ZlYyBtb3ZlIHNpemVkIHNpemVvZihN
TVZlY3RvcikuIEJvdGggc291cmNlIGFuZApkZXN0aW5hdGlvbiBhcmUgTU1RUmVnLCB3aGljaCBp
cyBlaWdodCB0aW1lcyBzbWFsbGVyLCBzbyB0aGUgbW92ZSByZWFkCjExMiBieXRlcyBwYXN0IHRo
ZSBwcmVkaWNhdGUgcmVnaXN0ZXIgYW5kIHdyb3RlIHRoZW0gb3ZlciB0aGUgZmllbGRzCmZvbGxv
d2luZyBxdG1wIGluIENQVUhleGFnb25TdGF0ZSwgdGhhdCBpcyB2c3RvcmVbMF0uIFVzZSB0aGUg
c2l6ZSBvZgp0aGUgcmVnaXN0ZXJzIGFjdHVhbGx5IGJlaW5nIGNvcGllZC4KCkZpeGVzOiA3YmE3
NjU3YmM5MyAoIkhleGFnb24gSFZYIGhlbHBlciBvdmVycmlkZXMgZm9yIGhpc3RvZ3JhbSAgaW5z
dHJ1Y3Rpb25zIikKUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5v
IDxtYXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29u
L2dlbl90Y2dfaHZ4LmggfCAxMCArKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90
Y2dfaHZ4LmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCmluZGV4IDJhMzQyY2RlZTY5
Li5kM2YyY2M3YmM2MiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAor
KysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCkBAIC01MCw3ICs1MCw3IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhpc3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogICAgICAg
ICBpZiAoY3R4LT5wcmVfY29tbWl0KSB7IFwKICAgICAgICAgICAgIGludHB0cl90IGRzdG9mZiA9
IG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgcXRtcCk7IFwKICAgICAgICAgICAgIHRjZ19nZW5f
Z3ZlY19tb3YoTU9fNjQsIGRzdG9mZiwgUXZWX29mZiwgXAotICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplb2YoTU1WZWN0b3IpLCBzaXplb2YoTU1WZWN0b3IpKTsgXAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1RUmVnKSwgc2l6ZW9mKE1NUVJlZykpOyBcCiAg
ICAgICAgIH0gZWxzZSB7IFwKICAgICAgICAgICAgIGFzc2VydF92aGlzdF90bXAoY3R4KTsgXAog
ICAgICAgICAgICAgZ2VuX2hlbHBlcl92aGlzdHEodGNnX2Vudik7IFwKQEAgLTY2LDcgKzY2LDcg
QEAgc3RhdGljIGlubGluZSB2b2lkIGFzc2VydF92aGlzdF90bXAoRGlzYXNDb250ZXh0ICpjdHgp
CiAgICAgICAgIGlmIChjdHgtPnByZV9jb21taXQpIHsgXAogICAgICAgICAgICAgaW50cHRyX3Qg
ZHN0b2ZmID0gb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBxdG1wKTsgXAogICAgICAgICAgICAg
dGNnX2dlbl9ndmVjX21vdihNT182NCwgZHN0b2ZmLCBRdlZfb2ZmLCBcCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNpemVvZihNTVZlY3RvciksIHNpemVvZihNTVZlY3RvcikpOyBcCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihNTVFSZWcpLCBzaXplb2YoTU1RUmVn
KSk7IFwKICAgICAgICAgfSBlbHNlIHsgXAogICAgICAgICAgICAgYXNzZXJ0X3ZoaXN0X3RtcChj
dHgpOyBcCiAgICAgICAgICAgICBnZW5faGVscGVyX3Z3aGlzdDI1NnEodGNnX2Vudik7IFwKQEAg
LTgyLDcgKzgyLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGFzc2VydF92aGlzdF90bXAoRGlzYXND
b250ZXh0ICpjdHgpCiAgICAgICAgIGlmIChjdHgtPnByZV9jb21taXQpIHsgXAogICAgICAgICAg
ICAgaW50cHRyX3QgZHN0b2ZmID0gb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBxdG1wKTsgXAog
ICAgICAgICAgICAgdGNnX2dlbl9ndmVjX21vdihNT182NCwgZHN0b2ZmLCBRdlZfb2ZmLCBcCi0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihNTVZlY3RvciksIHNpemVvZihNTVZl
Y3RvcikpOyBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihNTVFSZWcpLCBz
aXplb2YoTU1RUmVnKSk7IFwKICAgICAgICAgfSBlbHNlIHsgXAogICAgICAgICAgICAgYXNzZXJ0
X3ZoaXN0X3RtcChjdHgpOyBcCiAgICAgICAgICAgICBnZW5faGVscGVyX3Z3aGlzdDI1NnFfc2F0
KHRjZ19lbnYpOyBcCkBAIC05OCw3ICs5OCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhc3NlcnRf
dmhpc3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICBpZiAoY3R4LT5wcmVfY29tbWl0
KSB7IFwKICAgICAgICAgICAgIGludHB0cl90IGRzdG9mZiA9IG9mZnNldG9mKENQVUhleGFnb25T
dGF0ZSwgcXRtcCk7IFwKICAgICAgICAgICAgIHRjZ19nZW5fZ3ZlY19tb3YoTU9fNjQsIGRzdG9m
ZiwgUXZWX29mZiwgXAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1WZWN0
b3IpLCBzaXplb2YoTU1WZWN0b3IpKTsgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
aXplb2YoTU1RUmVnKSwgc2l6ZW9mKE1NUVJlZykpOyBcCiAgICAgICAgIH0gZWxzZSB7IFwKICAg
ICAgICAgICAgIGFzc2VydF92aGlzdF90bXAoY3R4KTsgXAogICAgICAgICAgICAgZ2VuX2hlbHBl
cl92d2hpc3QxMjhxKHRjZ19lbnYpOyBcCkBAIC0xMTUsNyArMTE1LDcgQEAgc3RhdGljIGlubGlu
ZSB2b2lkIGFzc2VydF92aGlzdF90bXAoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgIGlmIChj
dHgtPnByZV9jb21taXQpIHsgXAogICAgICAgICAgICAgaW50cHRyX3QgZHN0b2ZmID0gb2Zmc2V0
b2YoQ1BVSGV4YWdvblN0YXRlLCBxdG1wKTsgXAogICAgICAgICAgICAgdGNnX2dlbl9ndmVjX21v
dihNT182NCwgZHN0b2ZmLCBRdlZfb2ZmLCBcCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNpemVvZihNTVZlY3RvciksIHNpemVvZihNTVZlY3RvcikpOyBcCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpemVvZihNTVFSZWcpLCBzaXplb2YoTU1RUmVnKSk7IFwKICAgICAgICAg
fSBlbHNlIHsgXAogICAgICAgICAgICAgVENHdiB0Y2d2X3VpViA9IHRjZ19jb25zdGFudF90bCh1
aVYpOyBcCiAgICAgICAgICAgICBhc3NlcnRfdmhpc3RfdG1wKGN0eCk7IFwKLS0gCjIuMzQuMQoK

