Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A1CC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qb4-0003dv-HA; Wed, 23 Sep 2026 13:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9QZL-0000hc-D8
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:15:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9QZH-0001od-QG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:15:42 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTurm3665903
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OQ5RaKyuEciAXfaMVoDzP/XmPFNA4e6v5saZuF89tis=; b=mORVC6NbW5r31ls7
 A27OohoDb113I6Jd3aa5xBxP6EleXD4E/VAlgd9Yyc8LaW1hniMKTvEkbs0KPYNE
 S6dJWPBI5zB4DRa8xGVqg+LjVnQagq0HpkTPL2dBHD/UBXx0W3aQnXWRQZ5kNXTy
 6Pt7wXW95E8WyToGdxToxaH/LucH+VbHwXVkmG1/R/uPElAGj969hTTi1pzqbMwV
 WhaV/WCmGzc3UUWS/idZaWc/iIXjZiIiLqdaUn5dTsxoIXVw3lU+RaCyryItjzrr
 MWphQDD0l7F9C+lE7b/maQVjUY3gCyUA7zLHgh0TsEZ9cPB4JdtzepSDoTMLsSYb
 Hd8qRQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwat21p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:15:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbedbd182f5so54905a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183738; x=1790788538; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OQ5RaKyuEciAXfaMVoDzP/XmPFNA4e6v5saZuF89tis=;
 b=PoDA8G3btC3339xP6UQuyJ9WfHRCKRz/1CamQU+iGloBgUjaDOLESJmNcpJqYitHqd
 vyvWGMZ9jiEcWg03O6At41tDxWJBZdbfKwcZ/uD2j06jBtBlkOYmnflou/n2pLDMRH6E
 eLhtl2zDqW7rRDtxlprsNihmESmcD4VjAxnpHcLaJn4q7dnFKhVcw5QJQYAZrlC790rV
 fi+PTOKPyWYZMXIh5szZbOTUZ0CGkV4UY5+qDX4/z0h6Kq0hZIqyhYd0B7e6pEi/R3yi
 QNW/Fo41l2maHgdDhq+Yo3t+LfrOGC3SfHcD8EecYjSiXSGp9WfeW1bt5AAWDnR9zFcn
 MQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183738; x=1790788538;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OQ5RaKyuEciAXfaMVoDzP/XmPFNA4e6v5saZuF89tis=;
 b=h+148PxEBBWYQfsppxXU7lB8FqbrOwO5BQ0HPXvF3ObWHNV6kbpYaXOXIfodklVvHG
 o6I8m8mfUBIHvYQxwcnYEaDSsTZAw/86wYKFPEGzW1qrnKnCLmGRjLkUllM2uExQLRzE
 xq1w4mA8c8bPSeRhbOUsHFRXJCawrWq0LTGd6ATG/kjMW8PxldnT9hWmHOQfCS0frBgi
 dE+F8mLc2idNI3nF3xlu+045Mx03MZYwhksYLcqz9Ev5uT5x7RYBLoELb2dswvvvQD9N
 nIAB3IqeT/YxXQQtYgzstI7KpEtBj0mXRcchAgWr/6I0vdRihzDVrpjooFi7ptezq7Rk
 UH6A==
X-Gm-Message-State: AFuF++lL8LPau8BenHASLr1o9iyHGGC9+YDwQR2KknDmtbaVtR+Qj9N/
 voSPhb4ij7xUXwKCZgFA7/kP+uuhEJ9OYOkXwcipeQ3ELPGNZ9Hgzj3YrnAR5TpLxB7jGN3D58c
 hc1TUsnWJbqN4OaqpQvIghLjdjrhmYc0oRTSxOyvwHOkQdKKZZ+ldrkPsyu/xYOOD8Q==
X-Gm-Gg: AYBFou0S4rriIvugFaiiFCwZFE6ZGCGVYfE3w9zTbghdp2gPpTogeqFOiWHW2fl8zBE
 bux7elJ8IJco8afiQ3iKD8hFgBwUfzz59zI3tCj2ShWFX4i9W0mYjRAjTQQSdmnZdqrjy7+eh3T
 G+54TuCdLFqI8vcj/uvxvRePeRxqmD8CA6XbVRt2h1dyomKacAFhHAlb8Mxu1+9vn31GrIh4SA3
 gQFt2zRqYws7f6KrU+TUdue9aniv2+Th+0p1MCz0okG/j9JEZDopow0/6R/iEbqqJVV6xcDijgB
 jgWZ9IPVpi0oNdsIEnY5HRZgEtI0nqmjk46Oa3UEroPtZ4Quq6X+etPJBoglVXMaiXRaA3nM7TR
 lJp9xOrJVBcLT1qC9eeFsS9TTJV+ZZaUD76FOM4X+E79U2sa4MEJyUCc2ig==
X-Received: by 2002:a17:902:cf06:b0:2cf:7db9:e13e with SMTP id
 d9443c01a7336-2df69877962mr20993145ad.3.1790183737899; 
 Wed, 23 Sep 2026 10:15:37 -0700 (PDT)
X-Received: by 2002:a17:902:cf06:b0:2cf:7db9:e13e with SMTP id
 d9443c01a7336-2df69877962mr20992765ad.3.1790183737398; 
 Wed, 23 Sep 2026 10:15:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5f66b3sm14796035ad.73.2026.09.23.10.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:15:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v6 7/7] tests/functional/hexagon: add HVX tests
Date: Wed, 23 Sep 2026 10:15:16 -0700
Message-Id: <20260923171516.3794996-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923171516.3794996-1-brian.cain@oss.qualcomm.com>
References: <20260923171516.3794996-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX4sCq81OAKw7c
 tTuHbpQ1+OygFs0DwWAVWSahUnzz/JxwkZo8/dIedaEL/SYnOtRCAfWVwF1IZDkC9TJZojXfE+9
 YyyYKGodQIkb4WRtP9s7AZx+sW4kOAcdJyaQ6/MXn0T5dLBqi1ePQyqwqXt0ezDrWhIPYlUHDSi
 P42UzG5Mm77QspY3RZD3n5rjHmfw5Fq1DUJD7WP7sWr7DnaGTfP37m6Z1hUCYZlIjLQsSEAjXQZ
 P19Kk7hAem6qPgIdWMmLjGd6ux4KLtfGYEu2hUsaVAa7XMH3mz+fFZXISwSW3e118Cya9Oa4OOd
 Ypr4gJh69dc6ua7PhxGyNdQTjdPGwBSPZvCgMhoKLjrg01iIOPPP5vNf/2ms4ROO68gG4C6vqPu
 /CHAa2CLJNLsHN/1/NP+bep5NRYpnc52/QfJu/5Q0Hy4NTwZ61sGWgXJLXoz6kYnl1MYB2QPWxX
 6CnNlDcMyrzW+HePhVA==
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6ab4093a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=eq6FigJt9aAjue5lDr8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 0pITMK41JpDO-HAWxlB64FcWfx8ZKBxh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX04y480NUnRDh
 842uwETDsYexC7FgtrTP/2IuO2eDabmY8AslV7g5sqpN6+UyBpITyWmZlkh4NpbkY0g0cRplOI0
 PYyopNqanzDls2aT/OGdjGHOWZ34AyE=
X-Proofpoint-ORIG-GUID: 0pITMK41JpDO-HAWxlB64FcWfx8ZKBxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
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

VGhlc2UgdGVzdHMgcGFzcyBub3cgdGhhdCBIVlggaXMgbW9kZWxlZCBmb3Igc3lzdGVtIGVtdWxh
dGlvbi4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rl
c3RzLnB5IHwgNyArKysrKysrCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0
cy5weSAgIHwgNiArKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90
ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDQwZjc2ZTI1
YWU2Li4yOGJmMmYwMmQzOSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rl
c3RfYXJjaF90ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNo
X3Rlc3RzLnB5CkBAIC0xMTksNiArMTE5LDEzIEBAIGRlZiB0ZXN0X3VzZXJfbW9kZShzZWxmKSAt
PiBOb25lOgogICAgICAgICAiIiIKICAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X3Vz
ZXJfbW9kZSIpCiAKKyAgICBkZWYgdGVzdF9odnhfY29udGV4dChzZWxmKSAtPiBOb25lOgorICAg
ICAgICAiIiJUZXN0cyB0aGUgSFZYIGNvcHJvY2Vzc29yIGNvbnRleHQ6IFNTUiBYQSBjb250ZXh0
IHNlbGVjdGlvbgorICAgICAgICBhbmQgaXNvbGF0aW9uLCB2c3BsYXQvc3RvcmUsIGFuZCB0aGUg
Tk9fQ09QUk9DX0VOQUJMRSBleGNlcHRpb24KKyAgICAgICAgcmFpc2VkIHdoZW4gU1NSOlhFIGlz
IGNsZWFyLgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2h2
eF9jb250ZXh0IikKKwogCiBpZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgogICAgIFFlbXVTeXN0
ZW1UZXN0Lm1haW4oKQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rf
c3lzdGVzdHMucHkgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQpp
bmRleCAyNzc5ZWZhOTE3Mi4uYzgxMzdhNzE3MTMgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9u
YWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi90ZXN0X3N5c3Rlc3RzLnB5CkBAIC05OSw1ICs5OSwxMSBAQCBkZWYgdGVzdF9tbXVfbXVsdGlf
dGxiKHNlbGYpOgogICAgIGRlZiB0ZXN0X3RpbWVyX3JlZyhzZWxmKToKICAgICAgICAgc2VsZi5y
dW5fZXhpdF96ZXJvKCJ0aW1lcl9yZWciKQogCisgICAgZGVmIHRlc3RfaHZ4X211bHRpKHNlbGYp
OgorICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImh2eC1tdWx0aSIpCisKKyAgICBkZWYgdGVz
dF9zdGFuZGFsb25lX3ZlYyhzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJzdGFu
ZGFsb25lX3ZlYyIpCisKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVtdVN5c3Rl
bVRlc3QubWFpbigpCi0tIAoyLjM0LjEKCg==

