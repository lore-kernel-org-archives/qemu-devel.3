Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8176BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3dv-0003K2-Ms; Mon, 29 Jun 2026 00:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3da-0002um-OX
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dU-0001UK-M7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NCTx1771912
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=; b=X924drqt0OhrtJiM
 M+ztbRjyE7QVHWqC1KZx9UzHV0aGN2xI5/QcDRFEwidSaq0WSZtkAmB/W3EBOi/a
 tjvQqnQC+9EC0Pu/9WXqbI8VZkKrsyVTz4Dox/QsSqdXnTXFRm+eFjJVBSadOK5N
 Ie14eO4O3DoI86dmrMNVsoddMbnzSVxtXUVd17PyvLtDXbmSMXfUz7yb93+5TY6w
 m65OOOSNVpNIG77jUSYcDjP3L9IlaMCFPF5dX+EcgOLRdUs5iUhm77pzYDITgy3M
 z9yiAZ94KQI85Rr4K3BENN0K3xF+MRG9m4/3Dix/F2TRCMXCppxb6hClSdIo85lX
 uCuVzw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27084dhe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so7192421eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707417; x=1783312217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=;
 b=Kcpi4bgCXOg5MLvgdcEzoNcai3N91XiCJTvJWo7UFL/6SrsF26rugCJRK7qFrlIrMw
 8Mw/IJVQscFVzwiVEKh1OhDWuT7B67ePlNMkUb7fgS21tR0UhuIXCouEjsfU6lMCmCpH
 GR4lJhkYacXEUzgJZVczzu2KxSVO7VIZ4aLnI6vSm9FybzjwhbBRjYf/MCfRG8k9UduB
 m7ZpcQR+1KB1nipUnazuaZ+KUJBV+EWi9g8WpXKcfKa94VxMPHURgCvyWF0FHuNahTKC
 SDugt2d9FkGSLuVpwwR/TEc5Rj+gwwhb3klNhBoG/FJjxdppbt+SBEN+5FCUG4v9fpN8
 dlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707417; x=1783312217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=;
 b=emF8oOWXtLd0TRqJ2tTRVborQ8fsGyoE0tpYuasvQuyS2g7viFmeBGlR1DAe3d1b2r
 A9nd1n/tVaNhMThf9wzpPLGIpjWN4tK10MiUhzCylsyrcNU3P588QGkQU1QwBeGYjDTZ
 3CzGrsfW1u+S1HLIyLjZV3ff7XObydXSExI+I10cLZ5pcI7SEcB6YEC6r4Ev/jMoBqFe
 PReyQZ86hZDJS1+xZBPlOSu8B0LzRaoFZIXU32b6k46nF1QOaIuyVvhv2YU9ydqR0DZY
 QSivqo1qBjKmiUXB8Uxr2mcn5+qMJNTgRvtnKCPIU+COxj33vtzN3Ie0BBzqCDnI4IgR
 B0lQ==
X-Gm-Message-State: AOJu0YzQJb6dbFtv7yb5pWPaBbw5rcUUVBitmIW8xeWq6zZ64bnGdhof
 P4qxZx9ST8AsIq6CCkOfMCW2Sk44xIJaCI3ef1NbqO6pT/WDTf2KwBrf0ZY0jrPv3/oYGPPm4lU
 awxrlrVPvs5HZsfSGfLRmC4DeBzVHgoWk+vHP6LNmV4IHSFNny6ybDUHZ6CPH47HnFw==
X-Gm-Gg: AfdE7cl+xOWw0E0IU1GcQyzbLo9kQGj5ozGGEC3v2Dwrt09vFfttqM035I2wbAI/LfA
 aEzdrMcTrvTUjmYcth6vi+iLeNWiGrK7AySJP7LYMO1kWQIyr0+8UXOrAfj8htUsR9zCs1Rjp7m
 16Gc/JW1FnPCdkcwRKQ1fQAMQJUtycRYWYBXVPsWGNiZZCH/w48Ne8vWOyNBo3BpAbmS3gvUGxu
 BfBzhkZeXDgN3nK/4aMXfP2Zz96u7yCQeDORfEEt4ungBGtE4aq9u1GsuUycKSTLd76c3Aafw7S
 ujTBF+Xnzn0vBAYNIWlfzCAQUHDQXrX63RCMvdYctPrxwcW+D7KiImxre3CCiDzBMmIN7CvcBVv
 iF8pBwk4B9l2agsF4wFaDge539MnywhbrBFEEc89ak4vxEugoA+cEHCS2Gc0=
X-Received: by 2002:a05:7301:6003:b0:30c:39b3:20cc with SMTP id
 5a478bee46e88-30c85124ac1mr15157247eec.35.1782707417212; 
 Sun, 28 Jun 2026 21:30:17 -0700 (PDT)
X-Received: by 2002:a05:7301:6003:b0:30c:39b3:20cc with SMTP id
 5a478bee46e88-30c85124ac1mr15157220eec.35.1782707416623; 
 Sun, 28 Jun 2026 21:30:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 68/77] target/hexagon: Add guest reg reading functionality
Date: Sun, 28 Jun 2026 20:58:21 -0700
Message-Id: <20260629035830.1520296-69-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a41f4d9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=IJQQmebJWjVxhimlKuwA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfXwf/trzMir10+
 c1RlR7mz1iFLIqXkgyAwWgkUmUrD8HqvbRqdFPAzkPXrngU/FfA5w4o+gVf7wErWoRSui7ZpUVg
 3vyh0LCrxHJMPV0Isqg3qG9lLE0NJWXMyTC3FBFt+Ffq2TC6mGkmfypsKQ9J0G3IuVTck5BPbut
 /FeRiNxUheIVnZT5DXeqRuIetBrb6IBONmk1gtCDjZntIQKxdYbn7iBjqw0aefTbrvXR3GxtKLz
 6rb+BmxTrcDoi5aZ7T9/QyYovgP+43CJujj9IYKNAMF4sDm4yWwND8hLi9/grn/5cPUxVmaKz5p
 gsUN0Mz18a6SD7n2cZk2giCXo7UWRLzIkGsdmp1tAqk+gZoM2b78YQ9ZDfJmMS3I77Smili/M5E
 x87V2uqjm2XX/HnOZlh/nS+abKU10RrwELai8XaFBzW+xlo8qZa8mcsJZRGP4Gs0k42rCcktWAF
 6ZXHLRzIOL8zL+Cgxuw==
X-Proofpoint-ORIG-GUID: 5mkrxDkdnSMBW5rto7WORhA0b0wM7h2L
X-Proofpoint-GUID: 5mkrxDkdnSMBW5rto7WORhA0b0wM7h2L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX18zfinL9zpBl
 xHCuqUOJ47jlTjixzVtmazJKSLSPRFaMgBkIR8dpivdDIzr4brB3JAKd8bqPT4Cf925JmxZgzhW
 T8KczjkZNJf9PvDIMZnvDw09tgNIdnI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290034
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRo
YmVybkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2lt
cHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICB8ICAxICsKIHRh
cmdldC9oZXhhZ29uL2NwdS5jICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMgfCAxNiArKysrKysrKysrKysrKy0tCiAzIGZpbGVzIGNoYW5n
ZWQsIDM0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCA2YTk1YTZiYzViMS4u
NGExMmRjMDQ3MjcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oCkBAIC0yMjAsNiArMjIwLDcgQEAgR19OT1JFVFVSTiB2b2lkIGhleGFn
b25fcmFpc2VfZXhjZXB0aW9uX2VycihDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAqIG5vdCBzdG9w
cGVkLgogICovCiBib29sIGhleGFnb25fdGhyZWFkX2lzX2VuYWJsZWQoQ1BVSGV4YWdvblN0YXRl
ICp0aHJlYWRfZW52KTsKK3VpbnQzMl90IGhleGFnb25fZ3JlZ19yZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCByZWcpOwogdm9pZCBoZXhhZ29uX2NwdV9zb2Z0X3Jlc2V0KENQVUhl
eGFnb25TdGF0ZSAqZW52KTsKICNlbmRpZgogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9j
cHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IGIzNWNhYWVjZmFlLi4wNmJlNWM4ZDQ5
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKQEAgLTc3MCw2ICs3NzAsMjUgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfY2xhc3Nf
aW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICNlbmRpZgogfQogCisjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKK3VpbnQzMl90IGhleGFnb25fZ3JlZ19yZWFkKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7CisgICAgaWYgKHJlZyA8PSBIRVhfR1JFR19H
MykgeworICAgICAgICByZXR1cm4gZW52LT5ncmVnW3JlZ107CisgICAgfQorICAgIHN3aXRjaCAo
cmVnKSB7CisgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86CisgICAgICAgIHJldHVybiBoZXhh
Z29uX2dldF9zeXNfcGN5Y2xlX2NvdW50X2xvdyhlbnYpOworICAgIGNhc2UgSEVYX0dSRUdfR1BD
WUNMRUhJOgorICAgICAgICByZXR1cm4gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdo
KGVudik7CisgICAgZGVmYXVsdDoKKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICJy
ZWFkaW5nIGdyZWcgJSIgUFJJZDMyCisgICAgICAgICAgICAgICAgIiBub3QgeWV0IHN1cHBvcnRl
ZC5cbiIsIHJlZyk7CisgICAgICAgIHJldHVybiAwOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0
aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19iYXNlX2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0
IHZvaWQgKmRhdGEpCiB7CiAgICAgSGV4YWdvbkNQVUNsYXNzICptY2MgPSBIRVhBR09OX0NQVV9D
TEFTUyhjKTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggOGEzNzIzY2JhZmEuLjEyNTk1MmFlZTU5IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTg3OCwxMyArMTg3OCwyNSBAQCB1aW50NjRfdCBIRUxQRVIoc3JlZ19y
ZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihncmVnX3JlYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcp
CisKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHJldHVybiBoZXhhZ29uX2dy
ZWdfcmVhZChlbnYsIHJlZyk7CiB9CiAKIHVpbnQ2NF90IEhFTFBFUihncmVnX3JlYWRfcGFpciko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKKwogewotICAgIGdfYXNzZXJ0X25v
dF9yZWFjaGVkKCk7CisgICAgaWYgKHJlZyA9PSBIRVhfR1JFR19HMCB8fCByZWcgPT0gSEVYX0dS
RUdfRzIpIHsKKyAgICAgICAgcmV0dXJuICh1aW50NjRfdCkoZW52LT5ncmVnW3JlZ10pIHwKKyAg
ICAgICAgICAgICAgICgoKHVpbnQ2NF90KShlbnYtPmdyZWdbcmVnICsgMV0pKSA8PCAzMik7Cisg
ICAgfQorICAgIHN3aXRjaCAocmVnKSB7CisgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86Cisg
ICAgICAgIHJldHVybiBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgZGVm
YXVsdDoKKyAgICAgICAgcmV0dXJuICh1aW50NjRfdCloZXhhZ29uX2dyZWdfcmVhZChlbnYsIHJl
ZykgfAorICAgICAgICAgICAgICAgKCh1aW50NjRfdCkoaGV4YWdvbl9ncmVnX3JlYWQoZW52LCBy
ZWcgKyAxKSkgPDwgMzIpOworICAgIH0KIH0KIAogLyoKLS0gCjIuMzQuMQoK

