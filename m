Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA16606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cm5a3nDX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bmdyGE4o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8Yf-0002tI-FY; Thu, 19 Nov 2026 15:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YU-0002p5-2M
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YR-0000s4-Qy
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:25 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJUXqH3367488
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rFR9IveaGEdOSwUhmBMq9AQdusj381LWePfz/bin8Ic=; b=Cm5a3nDXYhDxtu+y
 omUFXXe23FvGg1J7KHpJq5ebmWso66la4qI0nhAS0q0QXpA+baUQTfcSOivlFhyq
 fXXVFPTxfO/bPSO1sMC7wcgDpLfIysK6lFocUZETHdpfKR2kyljJnWWgYqsU/RsA
 01t2AGRGL7N/dxW5ENoyJKhcrpN09Dh4M8lz1LuQLqESDOisVgmxjIyTbNEsgJQ6
 hSp/mEAM6VSLR0ZVbpQ6Bo8KuCoWttC6NmTmKkat7dQZ8A+uB9yJgV1cXuRYO438
 N/KoqCjXBU4GSEJfVJrp6ySDJz5qdd4TN+gOI5Zv5L4ucPK1Nj3hr8kImQaia0Ot
 4wMZrA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5r5ve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3837afac185so285685eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795119382; x=1795724182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rFR9IveaGEdOSwUhmBMq9AQdusj381LWePfz/bin8Ic=;
 b=bmdyGE4oGcto7SvD7pQNLYgU2+W44/AlA2a7IPsDvcr8Uo0fBHBHV2p3Kq1di6hHKH
 nShl0kDeWjlOKSrVMhFpaInAR0J3V0dWir5M5SQiDLGcjojNJ2OQdp0fhUYBU8XRTuVK
 i24QFgz9UOwMJxh9sKMZN/GLHcH6C3zbOt3biW3FP2FZHoAhEPBA6jHCe229GunRrtPa
 iWXUy06VldqobZnGaSjVEBxFxLt7VTuAfkYDEyxC8TPowfKM6WGWR+I+KOFYJ5oNJsJq
 OdpjyI1ZF9i7zv2517XPWRfnDFxmbWttS2FeWabgCwx9+rf2sADhE726I48GceO2Y9JS
 Hibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119382; x=1795724182;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rFR9IveaGEdOSwUhmBMq9AQdusj381LWePfz/bin8Ic=;
 b=wEyfSZ/wh9VzUcDH2IFzPP3B4yZ1XJv59368QoXPMf5JMpiCna+/7gEmu266UKJw/2
 61hGbpgVf56XF7gbevxh8yaBjVAvikSFxA3O5JSTnOE5EQmesT2rApLbrzZRo2Xl3jL8
 IDXvhgIXTN/WLQxiBU6Bt7O384v31z2aeDGVpnVFqwDa7sCNktbFBfh6A3ix1ck+bp43
 Dulq4UvAlUKqkv4w3DkwQnGlHivI8XKwqbZAP0zAmeFaPhYffyXxgj4sT0tJN+SNqyLp
 6SCsqaKu8PhD0yhLad6nHlgQGNlG4eXiGRV0er/VuRZlbJ5pGX7fCeI3nK7s865zGi9Y
 8uOA==
X-Gm-Message-State: APuU4Z+2gCNXp8VkH+h9bKt9fN549u6X2EwSAlQ8YuJYC8app7z0rSyd
 OEbSYxLQhG4U+9YlfhnTV0V7RIO6eplAR8+xk0zO+cfmAcm1toBodHGmVmTZwXhluHqbHBxcmVw
 7FSBCboYs/p9Q+I5EXSdBAExLVF09VzPCofDmpgSuxsT+HM7AyFtyTzsWGED4YBFuLA==
X-Gm-Gg: AZFdTZfAusAG1QWUssnSWjgGuj3+aH8BBJrCrLqc+5lAFhLvAIK+qnB3whN8kSyKgCD
 K60OK4d/uWZjnAoegXhXRlfLBoI35v40409Z26/ADvd3SRsCkdVQ1vj3KRZVpLXIE8wc5VGFXTq
 9KV55bVwW9zWmSWmrBjb/JXesj45LAznx2nvz/luUosyPOBtV+oBRyVFT0F86BLMpgy2BGdk2fm
 GIv9201MlebYTZsZBehJrsahv5U8MAQGsp7Vbr+MvZ8uiH0PRvhK/CvJEFf0j30+MS4BJ+6woEg
 KgGZMXODkPyrM6XHR8Qw++qMGS2OIKREykXX4dsQjl5D9bd/k7ddKANS4/OK6a5GMzxRiSCF+72
 Awm1bowNWzK92XkA1I6uFfZc2ApshorZaErG1X6voFwl4J57Al2tn0gAqeN80erzhEGciUnNPu9
 KO4EbS9oI1CdB8g2Q4N61J1w==
X-Received: by 2002:a05:693c:88d9:20b0:383:9f52:e7b9 with SMTP id
 5a478bee46e88-3856f03f434mr441841eec.19.1795119381607; 
 Thu, 19 Nov 2026 12:16:21 -0800 (PST)
X-Received: by 2002:a05:693c:88d9:20b0:383:9f52:e7b9 with SMTP id
 5a478bee46e88-3856f03f434mr441807eec.19.1795119381027; 
 Thu, 19 Nov 2026 12:16:21 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm1132085eec.0.2026.11.19.12.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:16:20 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-11.2 11/14] hw/hexagon: honor configured RAM backends
Date: Thu, 19 Nov 2026 12:16:00 -0800
Message-Id: <20261119201603.2377989-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX9MmQDypVBUM7
 EM1sgN+RPoR5i8sE8bKAj3qJDu7JjX/M88wkgQqlgjUkqYsGanepl9EGQw97w4GgyNPGjpi5tpP
 Tzmq4ODMYZmfBmh/wqbh8ahygIBdUxE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX1TMKMuUJJT0S
 IoEG9FScDDi4H7s4SVOG1jvaeMsRjAGj85YiijeqvrbFA1x6j0c32EO3vxbUdiUEqLfS6kDpIov
 rs11YiMh+mDxByHjmVyid9W7Kmng0/m9dE2WFUlblX46NGeozUJEo6/tHfceUkgVDXSaHsbjKrj
 ZJD6p4FhNQtHZPWwYBT7gcuHfh253ldr6M22T8ZiNmsW5TXZwAijX26WhMybIJseRa1rQDYielT
 NQuFrRt9Zo98TJe1iV4GQSZ1YkPZHHyN39AZCxdUZzZE/zBzO0WBRx72UjbbgNgK6i9u70BF/0H
 P62PpGvF9y+NfG3uKjC8YrAITXBLo8W9Ar/Fz4H+x0cpazChKpaH0DfwZJaNjSvFkHCIAYjhgH5
 Q/CIan/+j6q3J2BhA6RMPaFovedsE5hx0rwzU9U3aVNAbchi0XswmiPqduIIxx3ba9sHST21yzJ
 fCc3GfVQ5TMqr+cASNw==
X-Proofpoint-GUID: l8R13DqOGJKX5yacxXcFUq_oisF-e4C3
X-Proofpoint-ORIG-GUID: l8R13DqOGJKX5yacxXcFUq_oisF-e4C3
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6aff5916 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=CClahisu4qSzJabnEcAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190080
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

