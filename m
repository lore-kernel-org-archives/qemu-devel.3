Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222FEC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2Jo-00010v-KB; Wed, 14 Oct 2026 12:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2Je-0000z9-3U
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2Ja-0001aD-0H
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb30d1013141
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +wdQOWWjrb2A+1zKjaniSXLm1/gTrVOZcbWWQj2p5Vs=; b=jUpYKfVRFVov3gPJ
 k6vDzus4yPfXL4rfKhUp5FCz2blJyxGSaMF1unle8f7TUZjnDu+WhAsCxliZaFXu
 /pB6bD7ru9ELg4jdI3odDejfws/j5X950jRv1Wbi7BXCAAH4n3KAjIuLeZD26EEl
 cx8125oSyhITeqqcZR6T5VQJgDXRvGzUc3HgJ/fWWqf1K1CmVFevgRE9qHg3RXJ9
 +xu8JtkGK8wD1Lzdm53bXbMk2oPd4b3+kf0YzJ6rSYRBu8C0slk69xmWbW06pCcS
 bjpgxBL/6UIp7lI8z6ClkzorfbNNu3VCz0Af07gO39t2GKfQKYsVVZfmuhAwN7PL
 spfmtA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80csj5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c3c370b17so4101130eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 09:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791997130; x=1792601930; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+wdQOWWjrb2A+1zKjaniSXLm1/gTrVOZcbWWQj2p5Vs=;
 b=ZDKGGHSBHqHBHIYzeBBLflDWnsN0sxDVize4Y53lX8MA4osXH380yGhE1DvJIU7sIe
 ZJUhSsI15xIzoHlmek7or8pZp5EUAKg7xYMoADKmlo/irxQPj3tPXFdIodVV/xzIf5Q/
 uV1Nubf+myG1TE0s2YOsAiRggg/pbJMU6XFuzlf+AjjrbJabl0mk/l8/a9rhTEbQ0MXV
 WOuALGx7b2+zyDOEIvuW1+qRlU/sPryZXYGxhW+acpkAtbL0wb7nCjhPDJ3izfVHrkrr
 F4O2cHv28q8H0gqzdsZjRnRGLO+w1H5xBMHM8ZaZX7ZOOmZSK7I60MWnOPECbos0a/a1
 iwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997130; x=1792601930;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+wdQOWWjrb2A+1zKjaniSXLm1/gTrVOZcbWWQj2p5Vs=;
 b=Lc9ml7fJmrRv6UNjgzdX6sMdq3bE4wEcXId+a8tHlRiMrk2zaqPyb2UuutuNLUT0mV
 9ll1O8PNDN+3X7fEN0fV7kTmoi4mUm8KwL77+cmPCfqykt9bcoX1HY69s0t3c6lKVwjB
 9zqiW4qGF1Omehz4KwxY9XC6gpb9u8gpuuw/Uwff7fRJmDwAIhEbyR5djkObg+upJ4hx
 TYgrv7HfC6mNQnT31mttu+nQvQ/HwUwqpAj96eD6YuyMe+CTDOKXC3GZKJCxwujwulru
 AkSTyJRkJSmmVMMnGYwIQrm+fS2W1Spex5SdjMN3MwWq0kZsZNkXtsH/F6qlaOkDpVTt
 rnFg==
X-Gm-Message-State: AFq9FYJ+9xywnJBW0wxjFcZ7Z2zjCXa/+xQs6IEd5FymYQzuqcW0lsep
 744vR0P90+1xWMGje1fvJ+z0Ix/PttHA1gXhwHkqIlhtZ8cyWF1p3iyyUQMWTtAOE1SK4/9YdSg
 QJMajHuVdD+zFwKthAkbNliyMGWcr2y9LWEqNuQoqpacFq1MDn7KCeknPYwtxBlg+Qw==
X-Gm-Gg: AYBFou34Zsoqc8SpNKD0eCjrQCfEv9VxZi6RUtfwgn8YRj4zivg2lrfD0br2dSuFJNo
 PMJkz96aZfIdz9bbC2DFPk7XzNZd+hwENBlvHKW3bOQl/igxk19JDgKMOQbC0LPyYXE4rSW3F6T
 4gQQ+YJ/iDduPag+toN10dgkzXeA1QBBnOTLrwavTTPdpS+iz+kDSVIY5guP/gT9z0A9k03KifF
 cFynzlb1M2EgELmJHSnLuoE0DD6u8SiEfQUL6bMjchagEju3Mr0Cq+FzbxyByuPoV22PX+Q3wgK
 vQCihY2C9BgStNb6aN/4OGYwLySNARuSzqG9NlYzVL/mB1oD7a8Ah36L/dFiHUsetWbxIs4OlWi
 nu+P6LoDjQTyIvUwn70AZvCfRdduTOvCQyMTdtTmT6WMlf/M=
X-Received: by 2002:a05:701b:2806:b0:169:3706:d61b with SMTP id
 a92af1059eb24-16a5dbfddfdmr21967857c88.16.1791997130290; 
 Wed, 14 Oct 2026 09:58:50 -0700 (PDT)
X-Received: by 2002:a05:701b:2806:b0:169:3706:d61b with SMTP id
 a92af1059eb24-16a5dbfddfdmr21967826c88.16.1791997129592; 
 Wed, 14 Oct 2026 09:58:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-17dc865cbffsm11137939c88.6.2026.10.14.09.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:58:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 5/5] tests/functional/hexagon: add MiniVM, lock tests
Date: Wed, 14 Oct 2026 09:58:37 -0700
Message-Id: <20261014165837.2916482-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
References: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX58RajXe0MsgY
 mk9VpvCvJN2QDd0x+133Zi4PP6wnwxhRnw5qXwms6Ep3DADCaSqmCXg/+tRJjRlTXNytPsX3VjD
 3gzG6DIyJarONFTHxtShCyAOb0LgU7A=
X-Proofpoint-GUID: eEGR1fkXec8AWq2GsH-waXE9EN9JMgPf
X-Proofpoint-ORIG-GUID: eEGR1fkXec8AWq2GsH-waXE9EN9JMgPf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX8G0GwIe/dzl6
 vOjT4PEsVyn8yHUnTcai5LvFYtJvjqROwj1XtlqHlw8YaRabmykBKaz51V2j/OX8htKMI5Xz+nn
 Cpq6FgRu65vOJs4gCb3lWUtC7+4o9CYi8pPjq2PYu+JWGSkExz8ACM94N9juJaUnwm6XPqYWOey
 Uc8DiEDd+YyQNFohn9tttA2l/vOOeU9meJIO4KnDp0zYo8gOx42CqJkIWYDQBX2BpTmLnL6btPu
 PMm6s0DymPPxC+Oj4rzL/lMWOos4QTZ7kHuTc/4DOrvLgCH2z01gLsHvGCTLt9LGi5IzhCLAAYF
 f9aoGJ82KyNRJ+rmhWLfdhFkNcduUHLGI3+V+pbRGQPUD08rd0Wiz70m1ijBGWJyamUgNoXNkaK
 g+tgDBTC7EQQgwLfddGWr2pjhi25dEilxbYh5maCmXJevfDfmy2MaSvooKLQaXM3AG+0Keq65FI
 2M3OMpLko4H2tS4Meew==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acfb4cb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=N306dsr3tXGB1petHgEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140067
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

QWRkIHRoZSBsb2NrX3ZlcmlmeSB0ZXN0IGNhc2UgdG8gdmVyaWZ5IHRoZSBrMC90bGJsb2NrIGJl
aGF2aW9yLCBhZGQgdGhlCm1pbml2bSB0ZXN0cyB0byBjb3ZlciBzdGFydCgpIGFuZCBtb3JlLgoK
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgIHwg
IDEgKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfbWluaXZtLnB5ICAgfCA0OCArKysr
KysrKysrKysrKysrKysrKysrKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVz
dHMucHkgfCAgMyArKwogMyBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspCiBjcmVhdGUg
bW9kZSAxMDA3NTUgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfbWluaXZtLnB5CgpkaWZm
IC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkIGIvdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IDQ0MDUzZTY0Njc2Li5lMTgyYmM5OGEw
NiAxMDA2NDQKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkCisrKyBi
L3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtMyw2ICszLDcgQEAKIHRl
c3RzX2hleGFnb25fc3lzdGVtX3Rob3JvdWdoID0gWwogICAnYXJjaF90ZXN0cycsCiAgICdzeXN0
ZXN0cycsCisgICdtaW5pdm0nLAogXQogCiB0ZXN0X2hleGFnb25fdGltZW91dHMgPSB7CmRpZmYg
LS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9taW5pdm0ucHkgYi90ZXN0cy9m
dW5jdGlvbmFsL2hleGFnb24vdGVzdF9taW5pdm0ucHkKbmV3IGZpbGUgbW9kZSAxMDA3NTUKaW5k
ZXggMDAwMDAwMDAwMDAuLjExNWYzY2YzNzEwCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uL3Rlc3RfbWluaXZtLnB5CkBAIC0wLDAgKzEsNDggQEAKKyMhL3Vzci9i
aW4vZW52IHB5dGhvbjMKKyMKKyMgQ29weXJpZ2h0KGMpIDIwMjQtMjAyNSBRdWFsY29tbSBJbm5v
dmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorIworIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorCitmcm9tIHFlbXVfdGVzdCBpbXBvcnQg
UWVtdVN5c3RlbVRlc3QsIEFzc2V0CisKK2NsYXNzIE1pbmlWTVRlc3QoUWVtdVN5c3RlbVRlc3Qp
OgorICAgICcnJworICAgIG1pbml2bSBpcyBhIEhleGFnb24gaHlwZXJ2aXNvciB0aGF0IGltcGxl
bWVudHMgdGhlIEhleGFnb24gVk0KKyAgICBzcGVjaWZpY2F0aW9uLiAgVGhlc2UgdGVzdCBjYXNl
cyBib290IG1pbml2bSBhbmQgdGhlbiBsb2FkIHRlc3QgY2FzZXMKKyAgICB0byB0aGUgYWRkcmVz
cyBzcGVjaWZpZWQgYnkgTWluaVZNVGVzdC5HVUVTVF9FTlRSWSBhbmQKKyAgICBleGVjdXRlIGEg
bWludm0tZ3Vlc3QgcHJvZ3JhbSB0byBleGVyY2lzZSBtaW5pdm0gdmlydHVhbGl6YXRpb24KKyAg
ICBmZWF0dXJlcy4KKyAgICAnJycKKyAgICB0aW1lb3V0ID0gMTgwCisgICAgR1VFU1RfRU5UUlkg
PSAweGMwMDAwMDAwCisgICAgQVNTRVRfVEFSQkFMTCA9IEFzc2V0KAorICAgICAgICAnaHR0cHM6
Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUtaGV4YWdvbi10ZXN0aW5nL3JlbGVhc2VzLycKKyAg
ICAgICAgJ2Rvd25sb2FkL3YwLjIuMjEvaGV4YWdvbl9taW5pdm0udGFyLmd6JywKKyAgICAgICAg
JzU5ODA3NDBjNWZhNTA1ZjU1Y2FjZDE2NDYwODg4MzEyMDJkZjRjY2JmOWUyZGRjMzRiNjkwNjcz
NTc0MTY5YmEnKQorCisgICAgZGVmIHJ1bl9taW5pdm1fdGVzdChzZWxmLCB0ZXN0X2Nhc2UpOgor
ICAgICAgICBzZWxmLnNldF9tYWNoaW5lKCdzaW0nKQorICAgICAgICBzZWxmLmFyY2hpdmVfZXh0
cmFjdChzZWxmLkFTU0VUX1RBUkJBTEwpCisgICAgICAgIHJvb3Rmc19wYXRoID0gc2VsZi5zY3Jh
dGNoX2ZpbGUoJ2hleGFnb24tdW5rbm93bi1saW51eC1tdXNsLXJvb3RmcycpCisgICAgICAgIGtl
cm5lbF9wYXRoID0gZid7cm9vdGZzX3BhdGh9L2Jvb3QvbWluaXZtJworCisgICAgICAgIHZtID0g
c2VsZi5nZXRfdm0obmFtZT10ZXN0X2Nhc2UpCisgICAgICAgIHZtLmFkZF9hcmdzKCcta2VybmVs
Jywga2VybmVsX3BhdGgsICctZGV2aWNlJywKKyAgICAgICAgICAgICAgICAgICAgZidsb2FkZXIs
YWRkcj17aGV4KHNlbGYuR1VFU1RfRU5UUlkpfSwnCisgICAgICAgICAgICAgICAgICAgIGYnZmls
ZT17cm9vdGZzX3BhdGh9L2Jvb3Qve3Rlc3RfY2FzZX0nKQorICAgICAgICB2bS5sYXVuY2goKQor
ICAgICAgICB2bS53YWl0KCkKKyAgICAgICAgc2VsZi5hc3NlcnRFcXVhbCh2bS5leGl0Y29kZSgp
LCAwKQorCisgICAgZGVmIHRlc3RfbW11KHNlbGYpOgorICAgICAgICBzZWxmLnJ1bl9taW5pdm1f
dGVzdCgndGVzdF9tbXUnKQorCisgICAgZGVmIHRlc3RfaW50ZXJydXB0cyhzZWxmKToKKyAgICAg
ICAgc2VsZi5ydW5fbWluaXZtX3Rlc3QoJ3Rlc3RfaW50ZXJydXB0cycpCisKKyAgICBkZWYgdGVz
dF9wcm9jZXNzb3JzKHNlbGYpOgorICAgICAgICBzZWxmLnJ1bl9taW5pdm1fdGVzdCgndGVzdF9w
cm9jZXNzb3JzJykKKworaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoKKyAgICBRZW11U3lzdGVt
VGVzdC5tYWluKCkKZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5
c3Rlc3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKaW5k
ZXggMjBjNThmODRmNjcuLjA0ODlkYjBhZjkxIDEwMDc1NQotLS0gYS90ZXN0cy9mdW5jdGlvbmFs
L2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24v
dGVzdF9zeXN0ZXN0cy5weQpAQCAtMTA4LDUgKzEwOCw4IEBAIGRlZiB0ZXN0X2h2eF9tdWx0aShz
ZWxmKToKICAgICBkZWYgdGVzdF9zdGFuZGFsb25lX3ZlYyhzZWxmKToKICAgICAgICAgc2VsZi5y
dW5fZXhpdF96ZXJvKCJzdGFuZGFsb25lX3ZlYyIpCiAKKyAgICBkZWYgdGVzdF9sb2NrX3Zlcmlm
eShzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJsb2NrX3ZlcmlmeSIpCisKIGlm
IF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVtdVN5c3RlbVRlc3QubWFpbigpCi0tIAoy
LjM0LjEKCg==

