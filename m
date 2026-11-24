Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD14606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dOV2f8rB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JGsh5McY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvnx-0006uM-OU; Tue, 24 Nov 2026 14:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnn-0006pU-4l
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:42 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvng-0006iF-EH
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:34 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXQZ02752089
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rFR9IveaGEdOSwUhmBMq9AQdusj381LWePfz/bin8Ic=; b=dOV2f8rBNJnj0gyx
 SVYx0F1VbwZXgvHZ74U6SeYNWdD+Vr0g3uYEeA1FPaIyxmZtQFErQhoCQLhJgqPY
 iqoYj2gbhHgFFHcabO+BGZ57WN7T/S3NTKq/eXzG4X/srbBjU7yZyNrfXGZJ+Atx
 bn6NBla/CG+qr9hfr3KEQztr4CzmHZyjQ+AmeAYazZKBg2q8emFI+y2eJakq4e4a
 byii7NU3wR6Cof2n6K1DjdiPRVjUVQyu1RfjCjWbM1zYicx/lX6V4dY+ZQqlqEkL
 MBotu1qxTHIBYXf7ORp6mbxv8wjSzdvmaFOZ2leP/zKmdgm1XWaZTUQGuiEAhq81
 yZi1KQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvd4jvt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:30 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4b597558c4cso5661164b6e.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795547009; x=1796151809; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rFR9IveaGEdOSwUhmBMq9AQdusj381LWePfz/bin8Ic=;
 b=JGsh5McYuKdD09e7x/dqVHuO2+nFeRTxCW8iadJXsdeiooEOPfPWQ/2UJcvwFpeU2r
 q4VM9KWFuHTorkdxhzGn1IjfoqMtYPyQIfjqhZ8JyNimlGP/zB/D33tKNOCBTfBjtV+V
 eJO/tnoEBM9ZLhxDBDos4Ly3ZAWBhtFDqHmj/OuTprfW1QETHIYSQhN0YimSXTs3P5l0
 YN8R+/1pdx6SLivm0wAQsFwY2ceDqAEYeR3Qb2OzeQba/AAxgB2YkpYei9sqWWkKDv87
 VLsYnfUaHKMsEpvSwrCTHvNH4pIzhabvQSAIT1ilHOUZvkDcCgprLZRNdWrfyj9shApa
 cuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547009; x=1796151809;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rFR9IveaGEdOSwUhmBMq9AQdusj381LWePfz/bin8Ic=;
 b=Uxd0jmbx70q1nyFOgCJajG8ypJFz/7oFiZkplSpXSFxxJQf3p8iePBVeK9Mwo8199q
 KKM5GV52VnQxTKZHC/pDtSUIYLjFOPURD21wMHYX0eykW9RTwvAOxZzeaGT0G15z3SR/
 0yl58S4MmOPh4ZRKAHA/+RjWyIdG76NS0B8JeXUjMVylXbG+vVLzQ7FyLdYMjQyF0/sB
 6Biw6HwGPpRrEZX6Vt70GBWGve9k2XMzhhKo7j2ndAgbQ6NA7D0gSF2MmGdXkch2UxgW
 v1a5bQCNvhh1q4+Rir8jNmXuGQNUs18IX62iQ6bUwskbgxavwbDnbacQ6NoZTr4TcwAf
 dXYA==
X-Gm-Message-State: APuU4Z+l9RiQeYI0uTClRYtO1wFm6RpQetyXduaIZIAvg+/bvE8TqQUf
 8mto6eY/2/7qMgixx/xFXw/LjCcRD0so0V4/LplZSINNNZ88bFYOkXSQ3+bpR8wMHfBDzZJRd0K
 UK6c5WcnDxmQSgnrVVPFg0L5eEB374Ut+ksV1JZanzQ/T55LXpQ5MMwS5GMS6BJyWxQ==
X-Gm-Gg: AZFdTZfkrN0nwpoO4duhOP0O0R6JKjk791TcC2ZotyH5H1/HxvUO2vu4J/ScnH2Epw4
 mniZSxLPns7p/iI0FpE+SrIDuQVgYLlb43mKzSi/v776WDviYxJae8jkknv/MB/mSDkm2l6ZAZA
 DSgLvtI0Uz2mT/ZQ9RiId7S3YaKviovyPs511cOOOERNFlv9A0dxJPQCm2SR19CPMSHms98LH3K
 2ym5C8DnRXlh+xw+uZneO/6ifDm09E/r6XMosY5Lp2O74BusHun6OZJI+eMzVdhuBFa4Rk7LlzG
 mGIuXiNiR2Wqp9IC+kCFzrN5wVkZUJUNI/FxhIvjxVffrZWkZO1fpK3AkbjJT787o+jki6PRWi+
 Yqlf6CoAJQWKfwJyTAYldPYA7Daxg1mVZQ8JsUQhzM2Qcr/uuBstK3uQdr+VEgmp/TzX+YBI7Bn
 k3/g47JlDaeZoRtstm/V2SnA==
X-Received: by 2002:a05:6808:4fca:b0:572:e0b1:18f4 with SMTP id
 5614622812f47-57a0a405395mr17310740b6e.20.1795547009427; 
 Tue, 24 Nov 2026 11:03:29 -0800 (PST)
X-Received: by 2002:a05:6808:4fca:b0:572:e0b1:18f4 with SMTP id
 5614622812f47-57a0a405395mr17310705b6e.20.1795547008943; 
 Tue, 24 Nov 2026 11:03:28 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a31929223sm12343195b6e.1.2026.11.24.11.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:03:28 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH-for-11.2 v3 7/7] hw/hexagon: honor configured RAM backends
Date: Tue, 24 Nov 2026 11:03:14 -0800
Message-Id: <20261124190314.3882017-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
References: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6b05df82 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=CClahisu4qSzJabnEcAA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX11L5U2IJT5rJ
 OEneqMc28OOIpnt5+2+ZzK59A33Lbl2lEM6d9k/zrXk78IejD08+a+5MYpI029UirkfO9liwQgt
 HMgrtp7ku51kwxnLpOuMAAZ6Rz/Avq+5SSEHcXe7ayhi3Gxv425v2S+KJ7iyYpOqw+LEDDsyMR+
 ZgQawBFNOga57RAEGwtA5HCArhsDg5Avsk8Zuy5jO0TM9xW+dJ07hPvcp4aMxFeU+J0Egb1INxm
 QNWC9BIvOx2gz2ZoI4qGDVOWRT43AEjGXaKyVm5FOEK8IBj765oJ7Dc78qdm3IIXstnvbRsD3wW
 Bm7R294a9++mzIMGiyp8CojV1ow2gj28G8g0xGP15Dh+FEHtLeHOXh1blTED0jWlvjf8xTEE06b
 FjI/hIHF/7tJYNpvC3EVqVLSii7d48jtHDIaQO2ExeNes7Mf50VlOF+4FN2vbgNNN3kgdJgrcDr
 AjxBr3cFK14k9yYMtqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX73alw3NwLICy
 GXbO+7dzgUzx5/nPohmpmX0274cldQnKtmof5K1GA6gt/6I1Igm5SmId25Je/QMAXBteRgXk6uq
 raDZzJafUvmwn4rvW7QmempcbmXdvXE=
X-Proofpoint-ORIG-GUID: TGq-y1VHdKoJnAG-B0H83rD0W6iP3wFb
X-Proofpoint-GUID: TGq-y1VHdKoJnAG-B0H83rD0W6iP3wFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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

