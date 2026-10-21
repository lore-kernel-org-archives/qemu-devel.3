Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C8606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 00:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PsB6uHN/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eKl9SNTd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJKP8-0002DH-DO; Tue, 20 Oct 2026 20:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKP4-0002CI-MQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:42:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKP2-0006zi-7A
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:42:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KNVRP43074356
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2WvpjHfTHS/mrc53aLzVG5TlXLeYoIMeJi3OGpA9ilI=; b=PsB6uHN/SWHRumg0
 g2+drauubE4D1fpCTrOndE8aYQsbhNaAo9xysh0C6l0lnK9eQXPGIGFQKKWTOwO/
 esHzJSgwx6t4fwJO7nELKL9Tp0vQxHQMgKaS2iZCIh7bym8qOfz7PwuNUs4ShVJ/
 vquYs5+x4ZDVhuP+wrQW164OWZItDiCsraMU6Z2rP5YYBtpFOgN9DVU7Q5A05Xh1
 ftJJyor1xzUk4IXqKAv9dHrePz6m8OatXRqi6o0W8pvmDNzkvRuVs77lp9AYAaF6
 WzKpOSiNhpUDJWB+C6DhvT8RVJ08POzIVxHeuGcA3H0ybn1sOit9mrruTwtZdikT
 8KWCGw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r0arx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:41:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so749545eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792543318; x=1793148118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2WvpjHfTHS/mrc53aLzVG5TlXLeYoIMeJi3OGpA9ilI=;
 b=eKl9SNTd67KcHcVcJvhRGYPZ5nq5MZQdrCd/DEpBuSESzIsSOwFXjy9YdbxPpAh2Ee
 FV5OlJq+wTofN9yw95TctjC+sPkpj6jqogsqjHeZ942jn384eqw7Xv0YUbFYFrszcwRi
 UAueAvxSHS30WPGaII+tFYUmVnbQVmI/iFMk9QEO2effBUI3bN4FXLbyc1cAZVDe2/2u
 FCCfCIule6WVLddytMztusjlMt9Qm4KeM3q5brTH/sIJdCqaK5ZeD7cKMwvnB4m42+od
 8vzI5UxN9CZGFEUNH/IICZPa6DG8jaVibVJTBG7IVNIxNaavkmYS479pzfKQhk1zsN/O
 1ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792543318; x=1793148118;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2WvpjHfTHS/mrc53aLzVG5TlXLeYoIMeJi3OGpA9ilI=;
 b=Hv8am+ip9FdBP2DiHX+caQOLd8W25aOTGKZ3a+0qlP/sk1TgQL9ltp4LCisbkTF7ve
 uDKk2dg9Url1cQDMZr4ThTA65qglxCFcsHbUDOHUZT9x5BPnZk9K5Fi5rdEv7JRHsMie
 ZClCTOTi5mzXV5E1iNW/rX76y50ZyBYCnTONS6i7DkqcjjLL2TB+bJpbuQsApuWsdiYq
 1ldkr5vq7CJDnKLs7ynnOSzQlcEbLrp9Wi2hNhBAbgHOKFI0iUMGiE1U2/hS7PVV2ge/
 WjDjbypylz9v6kLDd26iX/KclqDy4nDsmC9wJIY2RRDgdKqO0iQgHBtwEpDsAGp2WwsH
 CFIg==
X-Gm-Message-State: AFq9FYImyC5vjvy/pufOnOtl9mroDoUFGZglLU868w5iIawGXVfZ5lAl
 gImHGfPc+cvduyXVC/plMQM9YCSQkBE40fEOTNI/Jw0wrrYhE1WIXekMpnzPPB3E7cmKB98GqEp
 nwsnQmWRnbLiq9prq9eOfJ/BRSC6CNBcOYBwHuXMnyFNF2tALKm45hsA97QFUEpou4A==
X-Gm-Gg: AYBFou1w+oQA0jVqkAzvkDqxncdMKQMv+dwMtn9HT8XxUSdQMlbZc7HPGllYwsknoCq
 1d3KZKOuiEVXXBfqgzbbrw+zE7+nkvhtoAuYGkMij6CtxzAMKAXzugtwI8lUBrAd2wpjOhuJA0k
 f4U06EvMfiKdC8MI4o+XQ171eifWw17lP0Vwe+9mXYdJkRjK92WtA7coQuQyLMD3KoDA3JbG8uF
 o7RrUNXpc3aROXfO6aX3Adgxq0Q2rb9f579qwNoQB7hqt6LdAxY9qqjudbaH7UK0mTJQomXhsUu
 C4QtcQxUMu2oIo9TTSfMe1ttDhkJK1+hoJ0YIYTyjexG9ivK5o6pVaJlSum0EbFd82CFfB9Q4Zw
 PFPep61+6E88vdsEK6kBdYVG/rPrimwKAxTNqAAJjAV8/Apc=
X-Received: by 2002:a05:701b:4212:20b0:163:bee9:b250 with SMTP id
 a92af1059eb24-190a52e0094mr652098c88.22.1792543313062; 
 Tue, 20 Oct 2026 17:41:53 -0700 (PDT)
X-Received: by 2002:a05:701b:4212:20b0:163:bee9:b250 with SMTP id
 a92af1059eb24-190a52e0094mr652060c88.22.1792543312374; 
 Tue, 20 Oct 2026 17:41:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d87ab1bsm2005788c88.21.2026.10.20.17.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 17:41:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Alessandro Di Federico <ale@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 03/15] hw/hexagon: let a machine place its DDR
Date: Tue, 20 Oct 2026 17:41:33 -0700
Message-Id: <20261021004145.1693260-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
References: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad80a57 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=aYFWVRUMB-liYKm9W0cA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: H4Y_Zp1ecH6QGojN9y93M7cZ179I6Gq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX+ngsUEdyd5XE
 SJPT5RB0lM0QiSuzGcAi/OMuRRd3hPCkgb1et1SWQi60K/xTuM/QbxPHG9EoX76WGUucLc/Fnl7
 uwhOxZ3aWwF0CngKAtgIjabRB8tH7l8eG64D8G6OpaWvAih8Sd73UuHaPqWntF2SjwP3XG55R6/
 UkP5TVGAMN5pml+qEqrmFnEg2Y2Hv6AKCWIpUI/BhhwS1mcd7LXgMI/s7rGZEzrjN5cGT6dtz60
 kxFg7euvppFRd0m705bEB2lah/V0WvdDZoosRtBhE2Kx1JZzj9Ybin8rwUk2KJr/wPIrfcqSH3/
 405Zm86OJ6T3DDWqwst71f2nAQswaqhR8TsYpMqzE24g24ef1fAyA/+ZWXd6zCBc4EBDqetfI5H
 yeAewIA9nRts/rxJVf4PP5Pu4VkUg1KmHQxCdL7slb4qWz3znAOv1U9+s4NiMZGRWComNzaJQPv
 Gici3d3TmAOEUEzooJQ==
X-Proofpoint-GUID: H4Y_Zp1ecH6QGojN9y93M7cZ179I6Gq9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX/H2BqZEu0SsF
 CXV4D9nWDzcu/V8gxiQ4D3gvnnBbeImulTsd2PICbbPncqrYUt5I9clZnERAOraqNqB49sDE3yp
 Vbic8eALnBFo2cybsIZ4jPEPnPYVJ4E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210001
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

aGV4X3N1YnN5c19jcmVhdGUoKSBhbHdheXMgbWFwcyB0aGUgbWFpbiBERFIgYXQgYWRkcmVzcyAw
LiAgVGhpcyBpcyBhcHByb3ByaWF0ZQpmb3IgaGV4YWdvbi1zaW0tc3R5bGUgbWFjaGluZXMsIGJ1
dCByZWFsIFNvQ3MgbWFwIGl0IGVsc2V3aGVyZS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4
YWdvbi5oIHwgMiArKwogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICB8IDQgKystLQogMiBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhh
Z29uLmgKaW5kZXggOWI1ZDMzZmZjM2IuLjY5NTVlNjAwYWVlIDEwMDY0NAotLS0gYS9pbmNsdWRl
L2h3L2hleGFnb24vaGV4YWdvbi5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmgK
QEAgLTE0NSw2ICsxNDUsOCBAQCB1bmlvbiBoZXhhZ29uX2NvbmZpZ190YWJsZSB7CiB9OwogCiBz
dHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyB7CisgICAgLyogQmFzZSBhZGRyZXNzIG9mIHRo
ZSBtYWluIEREUiByZWdpb24gKi8KKyAgICBod2FkZHIgZGRyX2Jhc2U7CiAgICAgLyogQmFzZSBh
ZGRyZXNzIG9mIGNvbmZpZyB0YWJsZSAqLwogICAgIHVpbnQzMl90IGNmZ2Jhc2U7CiAgICAgLyog
U2l6ZSBvZiBMMiBUQ00gKi8KZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jIGIv
aHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKaW5kZXggOTgxOGNmNTg4NzguLjM4MmY0NWJkMDlmIDEw
MDY0NAotLS0gYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYworKysgYi9ody9oZXhhZ29uL2hleC1z
dWJzeXMuYwpAQCAtMTM2LDEwICsxMzYsMTAgQEAgdm9pZCBoZXhfc3Vic3lzX2NyZWF0ZShIZXhh
Z29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAgTWFjaGluZVN0YXRlICptYWNoaW5lID0g
TUFDSElORShobXMpOwogICAgIE1lbW9yeVJlZ2lvbiAqc3lzbWVtID0gZ2V0X3N5c3RlbV9tZW1v
cnkoKTsKIAotICAgIC8qIE1haW4gRERSIGF0IHRoZSByZXNldCB2ZWN0b3IuICovCisgICAgLyog
TWFpbiBERFIuICovCiAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmaG1zLT5yYW0sIE5VTEws
ICJkZHIucmFtIiwgbWFjaGluZS0+cmFtX3NpemUsCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmZXJyb3JfZmF0YWwpOwotICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihzeXNtZW0s
IDB4MCwgJmhtcy0+cmFtKTsKKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oc3lzbWVt
LCBtX2NmZy0+ZGRyX2Jhc2UsICZobXMtPnJhbSk7CiAKICAgICAvKiBDb25maWctdGFibGUgUk9N
IGFuZCB0aGUgYmxvYiB0aGF0IGJhY2tzIGl0LiAqLwogICAgIG1lbW9yeV9yZWdpb25faW5pdF9y
b20oJmhtcy0+Y2ZndGFibGVfcm9tLCBOVUxMLCAiY29uZmlnX3RhYmxlLnJvbSIsCi0tIAoyLjM0
LjEKCg==

