Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B841C55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrphu-0002tZ-80; Thu, 06 Aug 2026 00:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpht-0002tB-HJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphs-0003EV-4C
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6763x6go483313
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WlYwLmXhxTTRa9JsiNHuhC5FeaNc/fhNT3n5nZwsxj8=; b=I/p2zrG7WSYNOI3H
 UT5hPF1aNWxbnuNQO6WNaxLwLUbUReCM3usLAUORkDH+je+VennoKAZStituZNJM
 2MTBCx3tOmuEe54toecy8n6Hnoti9+1QlwrJ8bCc28U1Csi9hxHqAdwVGtF6LRW9
 uFC2py/fHcGHtGRmLHaLfIaIBAf+W/mQ7Hg9CORN+qDmCSye1fiXlWwtJ3ud5zYc
 VV+pnhEMZJHv8QcA5P2MxSmTlrCK9DCLv0gm8tb+1Wb9S18cGEtLUd4K0iq87cPU
 hNsKCewfr8reTuX6zcT1hK4QCmdE7b8S42dqgOiMiPSyWv4ATxuLB5a16AtJG93/
 WZTIDQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjueg2ve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:27:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so2581692a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990466; x=1786595266; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WlYwLmXhxTTRa9JsiNHuhC5FeaNc/fhNT3n5nZwsxj8=;
 b=DpUQJUloqtWm/wcXa54Dgiiz8PMgf23RwOMJT2DLMaYvZOpoizBys53R3GdEqq3v7d
 6obcmxJHZDWrVLWENyiYKSSymzHsCjFvIz3Eztpi5UdbtUIaordgivcaQ9jlR5BOr588
 0vn7AxulfOfJBDRqAcU2kEU0U7B+X2sUgpOhAWafYRmgvZ6oD/gNbrSFeSF9+IZxCHs/
 zXMfPtjfof/gsw7eEi3RIeM/qnu9ogvN4GbZKL8squEiex0G1TPRYOzscoeawcAjn4Oe
 mZI9ouCleyOkdz8XMsmjluC0lwI15IxHzywjZDiBa2Zqj2cXxgi5hydus10DmIM3yOUL
 ouCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990466; x=1786595266;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WlYwLmXhxTTRa9JsiNHuhC5FeaNc/fhNT3n5nZwsxj8=;
 b=Lg73m2cTJCIZb70lBODaH6NoK/MnKVUSmU6TvAPN2kcbx5oWD8ENqapcTYXaVe5dN4
 8uvDNvoaAHS4CUMYi2N9sDO7u9jg24MO+aUayrlLTqRjO9pjNX1mAwWOnijPJHaVzDwn
 aWjT657nQ0ja7jKuLODx+mp41NamFYg5ktVV76KtsHIUGvXWBoG3joNcyXmfNVAdn0nZ
 pR0tltJ9xbx3lQe8L6DW/2rEswylB7arGow6yqbIFYDCVisGHoKNq5uOsH7tWCob5APh
 L5/HvIjCb3ZKIVNpT5S3EN57NJVKE88kgMltBue/MjyclxvxP7nHCq3xX3pybleYxnZV
 cKKQ==
X-Gm-Message-State: AOJu0YzmDO5LHWP4qFvnbLhLJfsUZ9vv3Yb8t377Q3BA70EB9ZDg6YDA
 bim1dA2YnCcsnh7/OZZ3H82SjbNhPodYAybSllPC+Sd0YRMA+ljSdrNyYFr1IQj1kXaMd1tPW5o
 osnrI41EMl0KPylLkpFHchsYWqBWJj/rNlyKop+Nytb0MHVCBJHHG58BKqZeem2jwQA==
X-Gm-Gg: AR+sD11dEgyq+b67MEfpa5hznbDYAl8U0J9Qq0wgA5/Ba9lS7ZZSND2MK+vR9lsaBmK
 XQRW09eV6qjwvnrcgxwR6uNWohtYNHbzr+TsoBBGxBz3n7yqTQ0YAz3RXSzzUiLiAqIMnMq44iJ
 jwsbfoV/8J8GLivQgcFD68ye3qtXunlUc2BMea3SqFmCnUjEpjn7H9vXZAfECLTA3cMV6sHmO+l
 XZOuMruHi9ulJGaCyk6A1Zm6tXkttB5hvkQ6rR/yVHjSGaHs3MIB0WhFKQm6UaPlxKLbgBoVVsI
 p8wt/G0iZoNY3Ioiw3+WEhNQ13GP2XEFDNh2TkBgNFmijVt+Bg8n9Bv/5Djjr8++FEdjp3wvppS
 vBy/CNu+97DX607NX0dh6PPtMUwQ4NibYXBrDbQjLZxbheulY
X-Received: by 2002:a05:6a21:3388:b0:3bd:187e:2de with SMTP id
 adf61e73a8af0-3cb85eef9eemr13975835637.25.1785990466091; 
 Wed, 05 Aug 2026 21:27:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:3388:b0:3bd:187e:2de with SMTP id
 adf61e73a8af0-3cb85eef9eemr13975788637.25.1785990465704; 
 Wed, 05 Aug 2026 21:27:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca926c0bsm19572628c88.14.2026.08.05.21.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:27:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 14/18] tests/functional/hexagon: add arch_tests functional
 test
Date: Wed,  5 Aug 2026 21:27:19 -0700
Message-Id: <20260806042723.3785369-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
References: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aNzAb79m c=1 sm=1 tr=0 ts=6a740d42 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=X9gmHREV3qooIQp-wBoA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: MSRcuW4IWgUXsMmm1dnOvYGmeIwYPnae
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX/Q759q4gJd9w
 su3utyJViYNJFBt6wRWkTePnOgviY6ql2Xs/We8H/6eHt0lEp3eqnHCMv7Nmp1GoeUCmnQ4Mm1Q
 Wo0uFKpmTYsxiJSfj42XjjqGPXx1bEboxFJVGbmsVflgVo5DKCYhkTCc0v0J97wO/9CVLZBlnec
 1rwx07iyab6btaXrohVzjFI4KZIjSDvaccWRvVobxbZKgFec2uK2RPCp15LC+V08aWzSfP57Jiv
 sGTDxopoMVZ2kphP9UD6goCTLW174AXc8d3B+AqW6m+zu3UKc8smXBqJV410vZUDBYKXazutgWY
 SF5Y0YR+AT8rOMhdcEcuyZ5cly/Xvnfud5rbLlFtCjVPSVh5JPIdKUrFJ1YajI/il+l9sLDQZSG
 X8a0K/f+WfRhxDGRCA+EyXOldrTYVbGjLsAIRLPfan+dnESr9r0LDtH5TYPnO2FFuE6hm3/g42u
 wmce02j4kSkGKFNW1Qw==
X-Proofpoint-ORIG-GUID: MSRcuW4IWgUXsMmm1dnOvYGmeIwYPnae
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX1eRoMzXitPBg
 tIXVH//sVLY3YYhgI6nlvyvApBw0UqysaVoyxgl9ZLPdxebl5fcbdb7DIcefHXeVy0j+z4wX1pq
 XDUCxDIpldsqRDDn6ERIOoiz9FCCJP0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060030
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

QWRkIHRoZSB0ZXN0X2ludF9zdGVlcmluZyBjYXNlIGZyb20gaGV4YWdvbi1hcmNoLXRlc3RzLgoK
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkg
fCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDU0YTE0MTJjNTk3Li4yYmIz
NGY5YjhkYyAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90
ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5
CkBAIC01Miw2ICs1MiwxMiBAQCBkZWYgdGVzdF9ndWVzdF9tb2RlKHNlbGYpIC0+IE5vbmU6CiAg
ICAgICAgICIiIgogICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3RfZ3Vlc3RfbW9kZSIp
CiAKKyAgICBkZWYgdGVzdF9pbnRfc3RlZXJpbmcoc2VsZikgLT4gTm9uZToKKyAgICAgICAgIiIi
VGVzdHMgaW50ZXJydXB0IHN0ZWVyaW5nIHZpYSBwcmlvcml0eS1iYXNlZCByb3V0aW5nIHRvCisg
ICAgICAgIHNwZWNpZmljIHRocmVhZHMgdXNpbmcgU1RJRCBwcmlvcml0eSBhbmQgaWFzc2lnbncu
CisgICAgICAgICIiIgorICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3RfaW50X3N0ZWVy
aW5nIikKKwogCiBpZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgogICAgIFFlbXVTeXN0ZW1UZXN0
Lm1haW4oKQotLSAKMi4zNC4xCgo=

