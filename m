Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DE8CCF2DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 05:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgJT-0006aI-NA; Mon, 19 Oct 2026 01:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgJ7-0006XV-40
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:53:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgIn-0001HX-0J
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:52:55 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4jCPN1408191
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2WvpjHfTHS/mrc53aLzVG5TlXLeYoIMeJi3OGpA9ilI=; b=gYPYWZxySL6PGMrB
 s/umtLV6zZuzn+Ml25/Cw3ClqAAmDId2wiLHmwqIorHLQ+clNfjf831FCqzo9cz9
 JeugE8C2XDoHcXnxyiJLRUg/C3u/yic0X/HNPot2x8LCUG8XVX+bLQLDQn3CN2N1
 vMq0Tzp3tHHeVk9R+nKIQ3mAJlXIaC1Dsy+V+o3kNHxloZe86PQYeLFtwNvczn4s
 6CyyfXf4eBSJS5G07mMy0oNDHudnv469LqfZiS5DFVhpyJjmrktET2Wq+Qajozk/
 4gTUrxzJV6wtjQWAIDFhA41bmZVskiJI0PAphvR1yRVsMMm2/Je9gEZ7BEnTvGjU
 JkszCw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr8ayr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:52:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so4022253eec.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 22:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792389171; x=1792993971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2WvpjHfTHS/mrc53aLzVG5TlXLeYoIMeJi3OGpA9ilI=;
 b=jtq390sS2vZ9AMrF7Gm6jEqPWlL3UUCqZ8yl5p7OpG0B8+NipFmGATvjF39QqsrqeB
 6VtkSi5Pv49vW3HEmJ9Zc0ZF/zEY7EZ+SllrZiRaJTz5TDFoU15iRUEDzNQOCT5jJkcI
 3NLTDqWfdi85gjQjyr6WIIk9I3kAV5/hT2+5sCTA5gccfqX0/PFblfuO+IHO9Gi7BySX
 3zz2lPpygZZTQeR+cWtpBGf2pUV6YX9od5DaSETu2nDDt5kS5+UcHO3vsCVu5jFXao0h
 jjKBuL3ULrzOtkqcNLlulzBspnVTxwnAr/xcFC00cKTOHcBc++iGvtlxPdzMA4nBpMDr
 ll6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792389171; x=1792993971;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2WvpjHfTHS/mrc53aLzVG5TlXLeYoIMeJi3OGpA9ilI=;
 b=B8qIzly+cVncHHCNbPHGKw2z12Yi48JqyxLds0J0zj13IayThlAXTgRVQ0m1DrjXnr
 N7goZirpDG2G+zJHFt8yTNJq6E9Ke+puXerb78TlShabEc7hDOWz5QsPTZYBae5Kt/F6
 yRVIxy+mA9W+jxe3AW5QI5hAbnGNKgb7PM7L0fQk52fs9u48oeW7r0uxKsF5t9p8UmSk
 S4BRYLvrfI07zKqoK9RMGbYeW+7qyp+llQVo6k9rkGXdWfoteEa11E+9SiXzRTHyvHzH
 ePk42EUp7bZdmglg/5qv/XLHnH8EYzno9Qw6llv6NuE/Ja4BUNwvBuXSFcbLjq54yP2k
 vFsA==
X-Gm-Message-State: AFq9FYKMo8xUc/L9hDAfsbMvmL+/K8pWu5CLiWw4htd5+p/N8SwqicBN
 2+1Ylmzkd9MuWDh2Bcx52SE9hXHy0PuAnrxfr/zIUEOU3W1Az5LY0SenJaig+2WqVl1YSdBCskF
 cCLT8HHgPLi/uXn6ODDAfyp8MKa745EDWYChgzG/YCfWW0VPnXMdjcZ8wRNl53qnf6g==
X-Gm-Gg: AYBFou3uiKwA6kZpIb/AJumJouVoHxc7+5cbQgvm/TDfN774i9nf27vOWM649HrqAIu
 Ly0lR/UDSRU/DYtE13nUx8KhZU08HQN+rNgMLiltLP1XZJwKUbQNH0utWBfl1NuXrCjxbFwqICn
 X3khEcETmHl5thWMfMfD1NLLdSEJy3ZTJzb7VRfljr6XgGPfqrLHVPr6ot2FzSVWYQeLbmpL/Ny
 GGXEZmg8spywh9x/+IsOMFBwzgiMx5tEjyiRVRVeCz/qxv/Y/G/YaGxK0JgYbgrMAdI81AYVank
 gC20UxHpueu5ZvJsCwE+1XArN2J1Jw9lvb5pzbqLPArSJj2OdCCGqO3myYzYTzJeE88tUynDMAZ
 qcJ4kdF/pvwMSK1cIAmKEuucJj8i0x9Sb3rn0R3LwgEJVsvQ=
X-Received: by 2002:a05:701b:2319:b0:151:2e62:fe8d with SMTP id
 a92af1059eb24-1851238b627mr9382475c88.9.1792389170853; 
 Sun, 18 Oct 2026 22:52:50 -0700 (PDT)
X-Received: by 2002:a05:701b:2319:b0:151:2e62:fe8d with SMTP id
 a92af1059eb24-1851238b627mr9382453c88.9.1792389170342; 
 Sun, 18 Oct 2026 22:52:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75ac0fsm25672781c88.15.2026.10.18.22.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 22:52:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 02/14] hw/hexagon: let a machine place its DDR
Date: Sun, 18 Oct 2026 22:52:33 -0700
Message-Id: <20261019055245.1457795-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfX/Wiv7wDFq26N
 Tl2r0wRLNujpUmHML7+xXjdc23O0MIX6YQuLV2pCHPTW2Tl133e4kfy38w5/JRlbtXZI/ESGa2y
 s6hlOArjtbKEw1uAMw+hzwdS2y4w9LeCDdlsq7//MHFVOJ4uI4Ixf5ICoNcVrv1SwWAyOCYATq/
 SDFW0crfnI95MU2bUoxX9V7hbC2Lo/IMXLAgxX8na7rtKxFA0RK5eYxrcQeeNpK0i3dLrrbSitA
 6eKsmGZGfFu3CWcp6kvOtkNu0kWKbDZp0LyyZNnbBwKPhCVKcdn50PqwgS1YwcyEH/r1DAMYDKd
 H/crSbK2jsKe0Y4CNe18CvUBip1qt4JnFtSK0i+5JlXDJmh7BgTXY5UkmdOKbUHJx8SSFlSm+p0
 qT0dYthGzn/gkus5vLcCw0iOZ9MHFC9mS6TtM3+ttehLRccfNNJOBD2+3k0IUrfWzIgYQ1dUa60
 +AzVfhWJx9zXvrfsnFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfXzdoUdt4OAlSP
 Ip//5kRlXQU4JCzubu5Gt2BR91jaAoYJtKtDAi0W8NvxTME/o+UrX9MuaZdUUEg+tgqE7eibOmA
 Tg96YhjVu68A0KRDmHyGrzs7plg8MeQ=
X-Proofpoint-GUID: isS4ON7GcRoIVIPp9VLuUbHDE9pw4WlU
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5b033 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aYFWVRUMB-liYKm9W0cA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: isS4ON7GcRoIVIPp9VLuUbHDE9pw4WlU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190023
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

