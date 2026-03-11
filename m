Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A33CFD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0B3f-0006LN-D7; Wed, 11 Mar 2026 00:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3c-0006KU-Qt
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3b-00030y-6f
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3wfT73419279
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=8O6Jdp/WT1ewLBFH/f9ST0NyS1Wf0WTkJWbxQcFHXO0=; b=p4
 dOnzt9fo97oDjIhxyQVkc22A8LUYRU4WrUGoRKyqComf9dXaquchuul6MeNq/0bW
 8pq0+QW7XMcBI8k+HqxAe5TcJsTFwB/F+cyGoIftFeiPMTjzu8AVCxzmRBoF8Ys0
 SNlJq98abPJd1ED8XfZDOF41UU6ZWMdLQwFChiFZUVB9DIsPG44IJiFU7gDI4obE
 tiWtYyWX1D9UvJBG4F70igP9LBCCb0A6LzJgUl7OqOwk2KAnndxu9aZl9SjzAHvb
 IOS9PHQt7Ox2g9AOkWJWKJfMnexxV7VLH2DA0jrVeO1/BLMkiAbjGuxRknu6+chm
 RLDqrW+UFn/6ujkcfpsw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2bb86-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:25 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d73bcdba71so39304055a34.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202825; x=1773807625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8O6Jdp/WT1ewLBFH/f9ST0NyS1Wf0WTkJWbxQcFHXO0=;
 b=amFTzoYqsQPCxy1XU2Roo9TXhY/zgovtMNbX0ulSMnqN9ky8NkooX/8kexfz7pwXIS
 0etIKTwPz8aRzsKeCyjlxgWOxgBmln47LR3vEZI3NG7AbQa5foDCCXqBspERByIyiL68
 shhRk60KUQCaERoEKO1jDuoIzj1TDVtuhmDGToaNLkf9KFsSgzlCl5NbAv2SPZTDRD9J
 DBopWShgbUJT4le1mc888aSlBfzy3pdd6KbZXvImkhP7ifq4rUCl/cLhxjtAh09kL24v
 5tsaCiUnZBaDZR9uOSEnfxLqlLBCfE61JKmmw8TSsbNkbtb98OnC0NVZ60+t3NeP1McN
 EOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202825; x=1773807625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8O6Jdp/WT1ewLBFH/f9ST0NyS1Wf0WTkJWbxQcFHXO0=;
 b=P+lPB4MbqIBKf40MsvytFo30qLrWEMXxJ+JLNZ7iIup0+YsO9uCf0UK/UJwBRS+NLS
 IvRUdAJKf/qSqWWlvgGdD9Y9FZV6zQGl1atPlGLmG8HZH/d8Bl6xYxhj3e2EUvcl5pTs
 YIS9aEsTMH9AliISHrY5K0wMcwOa6yKw0v2r6KRP3yNgQbTABt4OoiZa8zimtDKJ9/US
 VHR7vo1fxPtdMxymLAe6eJYZSavkvUlPHbpkgtH/mhzFQyI/oDDiAmXrTjxfMciXOHy6
 PxaAJTe22Zt6TbPJ5C12+cU/DvETUyv0dNdzY2X0glu+VzE5Bn6YGzFgaO2DqY5Myhar
 lMqw==
X-Gm-Message-State: AOJu0Yzuvn3XEE6QAWPYlRl7TgV4kzv5OfGS+XtgkxPhC88Fd1dRLt0N
 tsfJ7acjEJAxcnLU7kjqGlzFK+t4xrsxW6K/p2WKzYAp8YSg9g9KNAq0T/ZC+nfOZREw/xsGzdv
 hNnI7Jua2+jWIEdRFC0WthDgDFwUT4ID5boaesDDgyatA0aPGAXX+Kl1SmzSQGtYqGQ==
X-Gm-Gg: ATEYQzz6r6zIxVonnZlPiksRk+tYBheb4v4LLytVnMmoLwWlBC6q1Nlq9mkAn7NkPTI
 2JeKUQHtlC2FQw+9+M639LII5pQQ5BFotKl0zccR7oNqQfMycqIfyp52KrEi7r8SqV9MXOVcS5m
 bcmj8FZkfuqL71dSV8enNbyoRs62Ti8ZJaAPM1vjItJH/JugA2kkD4xh22X8SzvUrTVHL9vtTs5
 BHUIuggX/2XIyzzIMgqA0NJlyFRbbtt+AtLLuVJJ+0tCP+QXko++4c0m4dGoMNPVIqnj8BNIhVA
 JYPWW/V01Ob1fnbf/i/5Zd3eUhI1t6Q+XDzbWOAonw1yZUu6aFO2zo0Bp250Pl0rAlhU/0zWrjY
 i4giFT5+XQIZ/78cq2W6SzoqgvVH96Cgp8oArY93jvyRpVk83szvzc5TJGZJVk2j1IbyAvA==
X-Received: by 2002:a05:6830:6486:b0:7c7:2c3c:690e with SMTP id
 46e09a7af769-7d76a94bf6emr752392a34.35.1773202825310; 
 Tue, 10 Mar 2026 21:20:25 -0700 (PDT)
X-Received: by 2002:a05:6830:6486:b0:7c7:2c3c:690e with SMTP id
 46e09a7af769-7d76a94bf6emr752385a34.35.1773202824970; 
 Tue, 10 Mar 2026 21:20:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aeccd73sm892003a34.27.2026.03.10.21.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:20:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 2/9] hw/hexagon: Add global register tracing
Date: Tue, 10 Mar 2026 21:20:12 -0700
Message-Id: <20260311042019.1085030-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b0ed8a cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=w7TcP5jS4fsjDEBSHpAA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mLE3NNbZpwdu7lq-6TX6etcVnaBr7z7t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMyBTYWx0ZWRfXxEvxuH69EdB3
 sRl93D7VNAN5wXoLzUGYZ8j8royi1lbn1yEW97BOECp3dfVBwnfLZfQ1D1u8dRGODZI1xUxxEAA
 TdYwk6YU1ikQfHOvjtvQOc1fy67gGF+q/8NzHuzGu67gNh/fjEpvHg2WMzerMSf9t4p98pMXQbj
 Y/+0d+YiNIKfx0wcf/re4OW94ahhgm0dHl27VTjJfo+2O9BS34Ycn1UtxaWq5sFAB1Yw6gxQ7DU
 PZspPe14826vVdVHOmhTeB4Pj1VzXuROdCsDwd1DHo/str8UA5p3nbBAE1FGU2gsiFLC+f3Cvyj
 PYRr55nS1scRSN+xN2rG38r0ipcAbuTj70+F7DVq1nZxry6AY4PyvBvxzaRSGGDqMXsWfkBBeMv
 4MOeiG74j5ahjM941/B+lPp0UzHDsWLJMCh5iIbJ6sGL26oifpL3pfPg69mwN2QgqwnpqFBP++m
 PcyvRD0TkrFcj/mjcKg==
X-Proofpoint-GUID: mLE3NNbZpwdu7lq-6TX6etcVnaBr7z7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

UmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8ICAxICsKIGh3L2hleGFnb24vaGV4
YWdvbl9nbG9iYWxyZWcuYyB8IDczICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
IGh3L2hleGFnb24vdHJhY2UtZXZlbnRzICAgICAgICB8ICAzICsrCiAzIGZpbGVzIGNoYW5nZWQs
IDc3IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL3RyYWNlLWV2
ZW50cwoKZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVzb24uYnVpbGQKaW5kZXggN2I0ZTVi
YzcyYjUuLjI4NmVkZmI5OWRjIDEwMDY0NAotLS0gYS9tZXNvbi5idWlsZAorKysgYi9tZXNvbi5i
dWlsZApAQCAtMzYzMyw2ICszNjMzLDcgQEAgaWYgaGF2ZV9zeXN0ZW0KICAgICAnaHcvZGlzcGxh
eScsCiAgICAgJ2h3L2RtYScsCiAgICAgJ2h3L2ZzaScsCisgICAgJ2h3L2hleGFnb24nLAogICAg
ICdody9oeXBlcnYnLAogICAgICdody9pMmMnLAogICAgICdody9pM2MnLApkaWZmIC0tZ2l0IGEv
aHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2Jh
bHJlZy5jCmluZGV4IDUxODdiOTFkY2FlLi5hMzBjMTZjZDdiYSAxMDA2NDQKLS0tIGEvaHcvaGV4
YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jCisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxy
ZWcuYwpAQCAtMTYsMTEgKzE2LDgyIEBACiAjaW5jbHVkZSAidGFyZ2V0L2hleGFnb24vY3B1Lmgi
CiAjaW5jbHVkZSAidGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaCIKICNpbmNsdWRlICJxZW11L2xv
Zy5oIgorI2luY2x1ZGUgInRyYWNlL3RyYWNlLWh3X2hleGFnb24uaCIKICNpbmNsdWRlICJxYXBp
L2Vycm9yLmgiCiAKICNkZWZpbmUgSU1NVVRBQkxFICh+MCkKICNkZWZpbmUgSU5WQUxJRF9SRUdf
VkFMIDB4ZGVhZGJlZWYKIAorc3RhdGljIGNvbnN0IGNoYXIgKmhleF9zcmVnX25hbWVzW10gPSB7
CisgICAgW0hFWF9TUkVHX1NHUDBdID0gInNncDAiLAorICAgIFtIRVhfU1JFR19TR1AxXSA9ICJz
Z3AxIiwKKyAgICBbSEVYX1NSRUdfU1RJRF0gPSAic3RpZCIsCisgICAgW0hFWF9TUkVHX0VMUl0g
PSAiZWxyIiwKKyAgICBbSEVYX1NSRUdfQkFEVkEwXSA9ICJiYWR2YTAiLAorICAgIFtIRVhfU1JF
R19CQURWQTFdID0gImJhZHZhMSIsCisgICAgW0hFWF9TUkVHX1NTUl0gPSAic3NyIiwKKyAgICBb
SEVYX1NSRUdfQ0NSXSA9ICJjY3IiLAorICAgIFtIRVhfU1JFR19IVElEXSA9ICJodGlkIiwKKyAg
ICBbSEVYX1NSRUdfQkFEVkFdID0gImJhZHZhIiwKKyAgICBbSEVYX1NSRUdfSU1BU0tdID0gImlt
YXNrIiwKKyAgICBbSEVYX1NSRUdfR0VWQl0gPSAiZ2V2YiIsCisgICAgW0hFWF9TUkVHX0VWQl0g
PSAiZXZiIiwKKyAgICBbSEVYX1NSRUdfTU9ERUNUTF0gPSAibW9kZWN0bCIsCisgICAgW0hFWF9T
UkVHX1NZU0NGR10gPSAic3lzY2ZnIiwKKyAgICBbSEVYX1NSRUdfSVBFTkRBRF0gPSAiaXBlbmRh
ZCIsCisgICAgW0hFWF9TUkVHX1ZJRF0gPSAidmlkIiwKKyAgICBbSEVYX1NSRUdfVklEMV0gPSAi
dmlkMSIsCisgICAgW0hFWF9TUkVHX0JFU1RXQUlUXSA9ICJiZXN0d2FpdCIsCisgICAgW0hFWF9T
UkVHX0lFTF0gPSAiaWVsIiwKKyAgICBbSEVYX1NSRUdfU0NIRURDRkddID0gInNjaGVkY2ZnIiwK
KyAgICBbSEVYX1NSRUdfSUFITF0gPSAiaWFobCIsCisgICAgW0hFWF9TUkVHX0NGR0JBU0VdID0g
ImNmZ2Jhc2UiLAorICAgIFtIRVhfU1JFR19ESUFHXSA9ICJkaWFnIiwKKyAgICBbSEVYX1NSRUdf
UkVWXSA9ICJyZXYiLAorICAgIFtIRVhfU1JFR19QQ1lDTEVMT10gPSAicGN5Y2xlbG8iLAorICAg
IFtIRVhfU1JFR19QQ1lDTEVISV0gPSAicGN5Y2xlaGkiLAorICAgIFtIRVhfU1JFR19JU0RCU1Rd
ID0gImlzZGJzdCIsCisgICAgW0hFWF9TUkVHX0lTREJDRkcwXSA9ICJpc2RiY2ZnMCIsCisgICAg
W0hFWF9TUkVHX0lTREJDRkcxXSA9ICJpc2RiY2ZnMSIsCisgICAgW0hFWF9TUkVHX0xJVkVMT0NL
XSA9ICJsaXZlbG9jayIsCisgICAgW0hFWF9TUkVHX0JSS1BUUEMwXSA9ICJicmtwdHBjMCIsCisg
ICAgW0hFWF9TUkVHX0JSS1BUQ0ZHMF0gPSAiYnJrcHRjZmcwIiwKKyAgICBbSEVYX1NSRUdfQlJL
UFRQQzFdID0gImJya3B0cGMxIiwKKyAgICBbSEVYX1NSRUdfQlJLUFRDRkcxXSA9ICJicmtwdGNm
ZzEiLAorICAgIFtIRVhfU1JFR19JU0RCTUJYSU5dID0gImlzZGJtYnhpbiIsCisgICAgW0hFWF9T
UkVHX0lTREJNQlhPVVRdID0gImlzZGJtYnhvdXQiLAorICAgIFtIRVhfU1JFR19JU0RCRU5dID0g
ImlzZGJlbiIsCisgICAgW0hFWF9TUkVHX0lTREJHUFJdID0gImlzZGJncHIiLAorICAgIFtIRVhf
U1JFR19QTVVDTlQ0XSA9ICJwbXVjbnQ0IiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UNV0gPSAicG11
Y250NSIsCisgICAgW0hFWF9TUkVHX1BNVUNOVDZdID0gInBtdWNudDYiLAorICAgIFtIRVhfU1JF
R19QTVVDTlQ3XSA9ICJwbXVjbnQ3IiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UMF0gPSAicG11Y250
MCIsCisgICAgW0hFWF9TUkVHX1BNVUNOVDFdID0gInBtdWNudDEiLAorICAgIFtIRVhfU1JFR19Q
TVVDTlQyXSA9ICJwbXVjbnQyIiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UM10gPSAicG11Y250MyIs
CisgICAgW0hFWF9TUkVHX1BNVUVWVENGR10gPSAicG11ZXZ0Y2ZnIiwKKyAgICBbSEVYX1NSRUdf
UE1VU1RJRDBdID0gInBtdXN0aWQwIiwKKyAgICBbSEVYX1NSRUdfUE1VRVZUQ0ZHMV0gPSAicG11
ZXZ0Y2ZnMSIsCisgICAgW0hFWF9TUkVHX1BNVVNUSUQxXSA9ICJwbXVzdGlkMSIsCisgICAgW0hF
WF9TUkVHX1RJTUVSTE9dID0gInRpbWVybG8iLAorICAgIFtIRVhfU1JFR19USU1FUkhJXSA9ICJ0
aW1lcmhpIiwKKyAgICBbSEVYX1NSRUdfUE1VQ0ZHXSA9ICJwbXVjZmciLAorICAgIFtIRVhfU1JF
R19TNTldID0gInM1OSIsCisgICAgW0hFWF9TUkVHX1M2MF0gPSAiczYwIiwKKyAgICBbSEVYX1NS
RUdfUzYxXSA9ICJzNjEiLAorICAgIFtIRVhfU1JFR19TNjJdID0gInM2MiIsCisgICAgW0hFWF9T
UkVHX1M2M10gPSAiczYzIiwKK307CisKK3N0YXRpYyBjb25zdCBjaGFyICpnZXRfc3JlZ19uYW1l
KHVpbnQzMl90IHJlZykKK3sKKyAgICBpZiAocmVnIDwgQVJSQVlfU0laRShoZXhfc3JlZ19uYW1l
cykgJiYgaGV4X3NyZWdfbmFtZXNbcmVnXSkgeworICAgICAgICByZXR1cm4gaGV4X3NyZWdfbmFt
ZXNbcmVnXTsKKyAgICB9CisgICAgcmV0dXJuICJVTktOT1dOIjsKK30KKwogLyogR2xvYmFsIHN5
c3RlbSByZWdpc3RlciBtdXRhYmlsaXR5IG1hc2tzICovCiBzdGF0aWMgY29uc3QgdWludDMyX3Qg
Z2xvYmFsX3NyZWdfaW1tdXRfbWFza3NbTlVNX1NSRUdTXSA9IHsKICAgICBbSEVYX1NSRUdfRVZC
XSA9IDB4MDAwMDAwZmYsCkBAIC03Myw2ICsxNDQsNyBAQCB1aW50MzJfdCBoZXhhZ29uX2dsb2Jh
bHJlZ19yZWFkKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLAogCiAgICAg
dWludDMyX3QgdmFsdWUgPSBzLT5yZWdzW3JlZ107CiAKKyAgICB0cmFjZV9oZXhhZ29uX2dsb2Jh
bHJlZ19yZWFkKGh0aWQsIGdldF9zcmVnX25hbWUocmVnKSwgdmFsdWUpOwogICAgIHJldHVybiB2
YWx1ZTsKIH0KIApAQCAtODMsNiArMTU1LDcgQEAgdm9pZCBoZXhhZ29uX2dsb2JhbHJlZ193cml0
ZShIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZywKICAgICBnX2Fzc2VydChy
ZWcgPCBOVU1fU1JFR1MpOwogICAgIGdfYXNzZXJ0KHJlZyA+PSBIRVhfU1JFR19HTEJfU1RBUlQp
OwogICAgIHMtPnJlZ3NbcmVnXSA9IHZhbHVlOworICAgIHRyYWNlX2hleGFnb25fZ2xvYmFscmVn
X3dyaXRlKGh0aWQsIGdldF9zcmVnX25hbWUocmVnKSwgdmFsdWUpOwogfQogCiB1aW50MzJfdCBo
ZXhhZ29uX2dsb2JhbHJlZ19tYXNrZWRfdmFsdWUoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1
aW50MzJfdCByZWcsCmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL3RyYWNlLWV2ZW50cyBiL2h3L2hl
eGFnb24vdHJhY2UtZXZlbnRzCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAw
Li41ZDYyM2VkMjUxNgotLS0gL2Rldi9udWxsCisrKyBiL2h3L2hleGFnb24vdHJhY2UtZXZlbnRz
CkBAIC0wLDAgKzEsMyBAQAorIyBIZXhhZ29uIGdsb2JhbCByZWdpc3RlciBhY2Nlc3MKK2hleGFn
b25fZ2xvYmFscmVnX3JlYWQodWludDMyX3QgaHRpZCwgY29uc3QgY2hhciAqcmVnX25hbWUsIHVp
bnQzMl90IHZhbHVlKSAiaHRpZD0ldSByZWc9JXMgdmFsdWU9MHgleCIKK2hleGFnb25fZ2xvYmFs
cmVnX3dyaXRlKHVpbnQzMl90IGh0aWQsIGNvbnN0IGNoYXIgKnJlZ19uYW1lLCB1aW50MzJfdCB2
YWx1ZSkgImh0aWQ9JXUgcmVnPSVzIHZhbHVlPTB4JXgiCi0tIAoyLjM0LjEKCg==

