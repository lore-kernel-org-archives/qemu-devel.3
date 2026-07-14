Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE25C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfPz-0000xU-IN; Tue, 14 Jul 2026 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjfPy-0000x0-86
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:51:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjfPv-00013k-7b
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:51:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEcTt5862690
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=aAKiRjTceoIcMLwshSl5GF
 maABuwumRlPn9obRwI0wM=; b=IukdHSx0+wf9N8eadhT4zqBk++bjycLENmIhJj
 lz/NjN4V4T5h3vR82ox6dq4q1at49JvJV96KP7iAP1KQUM56jzRcQQY8ZD2vgkpM
 hs14x5vum5wnB5GlweibRFxtlgboDxP+Gc6h/QuCkFkH2YIcd7S31G+Z6VZ42mTX
 jI9+UXGClmXyOJL7bCWMFwhkoANR7GdUELV9DuxJGGziraX6aVDnpoPx9v1jwSZX
 xTGHQgGZE0HUttFb6YO4qzf/jmFFDpVA8dhSQtgR5+8p4SnbHfVQp3tAhKVaAnbf
 cx9EdNaq7t3pnfk2AnpQHwAb+0i7WrFBJmyPsQEzJ3hgic1A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmjq11fc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:51:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84870e7f498so5271741b3a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784044288; x=1784649088; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aAKiRjTceoIcMLwshSl5GFmaABuwumRlPn9obRwI0wM=;
 b=A8TCLeekDR8hWtCSZ404Xm+CTGCaJOc5NhFJrzmhU4mjhWnFLICENs1dFhd/fjH9VE
 s1kpv8NH3MXRO1gyG5ZbFNx1hWer1+360OtgUu5L7COva3VFQjW8H2zfOaEifvq51LXU
 V+CmgmTBw4LFSk4xKQdcYHGobpjuyaNaIcB+gbLC+fAIfCPTv7VyWf2xmYEsCTONJfKv
 D/2sQXik6f5AtEp9ZyzCpcg82oFp9K3d2JxueRE+Q144jSdYZ6VaLQSuXHlb612+tn+q
 DXkK7k0+Fj4XnUWQVCTIbBfxzO22QyVehaLGBzZRu5Vh9X/jyZugm47fn+xpcdKtW/9H
 q5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784044288; x=1784649088;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aAKiRjTceoIcMLwshSl5GFmaABuwumRlPn9obRwI0wM=;
 b=myJk0SHRo57Zvg6ik0B+6eUED9viAGCoRxDEfTfH8PuPiwU0nmZPDjr5xhcW2YBo+T
 ApKRNanjn/FE+SpqQ7YbeIOKgOev2CifSrYLg0ESiUrXiMCYghcHlRvR3bCXDg7edhNY
 wYZkE5bggOFuQmzrZiPveGyVZX4bhkQjQtMjKaaaBC9esboYrZCKAye0B3DdHdQa3jCj
 JV5EcYKpmtF1gOydf0R64gDA70/lo9ig2vV4zxVHr/hUwHAuU3q2tNOfWYKwoL1REJvy
 Lopubw0RnMROTHuFVJFwWqpBu/cZSTlKoPUT6hlcQCOoP3vrAfPsIu5172mRlOJFoHE5
 9s8w==
X-Gm-Message-State: AOJu0YyOgVGjIo11aNHTzOkv0qUkJTqSjjEKjbi6UtQExNURIZoFOLYw
 qjMClttAUCGUYM99LuOSnTghsQdc1k+nOKaV79wr15mNZO7xNkdkNzd8w3GKEQO/sEsKa806PhX
 KSDaLAQnhP3wwmT5/aQX5MR2THR/8mmYZFj69OHaf5vq8oSn0yWZketfkzjOl+qSGnw==
X-Gm-Gg: AfdE7cknKwrNCIvzN7VVEBWljDI3TfPohk0TPjzSfjPlTEF9OeKfPTYj13MY9JWR+UU
 CFSmbfVzvkeFVf6DSa8huwiQLSxV37seAl7j/ep9XB89RcnjdkUgqvEKAROY9jyTMIBEHpc4vgn
 qKbHWHzDsVGoG7rMA/gOeaKGa5sktObfaNSuQl0hkKENhoT0MUTPcu9KQ6K1TUJ4FQVGN8wW8Ev
 6nOmGiMSsqAxfXJ/xJKpf461R1ZnW3HHGvEQ7hueNYnsfkqyGUoiWZIzVodTnAgBekZKC3WhMIB
 AIq6+lZhXG9k2WXWDxACPCCwHsl46nc9yNtUHqVMUkTFCc2jbhYpokPuv7f12h80FpmvES0KT+p
 NfsdasDDMz/QJXqcY0cF6I0rUpMkQdx7hB7wZLobJ55e8x+c4ET5PnrvZ+p0=
X-Received: by 2002:a05:6a20:1449:b0:3bf:6c04:a819 with SMTP id
 adf61e73a8af0-3c110b3038amr15433174637.58.1784044288295; 
 Tue, 14 Jul 2026 08:51:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:1449:b0:3bf:6c04:a819 with SMTP id
 adf61e73a8af0-3c110b3038amr15433133637.58.1784044287717; 
 Tue, 14 Jul 2026 08:51:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b987fc629sm41343581c88.0.2026.07.14.08.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 08:51:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 0/7] Add hexagon l2vic device
Date: Tue, 14 Jul 2026 08:51:19 -0700
Message-Id: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=LqmiDHdc c=1 sm=1 tr=0 ts=6a565b00 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=dBR0pReTuG5vc_x2so0A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: IjKTvZGZn2Cvker66jEiN0OTxXE2vVl5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfX59dB20BvwKu/
 aJV5uKF8leL4PmWb03BiKCvOO9fOTKunQb1H0J1xV0Z/4pj39Pz7xJ2Dq+iHd/kPiHZfwF40r7y
 JzWxFVy78TXsTgyWgJePu4ls51CYv7bSB4E2ZWADZBuuFu6EsGbWkwPwJoen4jgyVE4uhmNOrth
 5BsfqCHCgAN4de9eVeVhdS2lSOKanAd39RoUtwjnydrLZv3KhY2NzHeoOpSPGcwCLxOPM5NqHbG
 31rXx5MCt12xeJ2HuRn9dFMDBTbtKL8Eq7hdoyCblU+x1szHV/jrzAWdZXAmKuLW+t4/xQoi35v
 xfV5h8+U1/W6xp+orOVYt7mYLwOew9WPRyXrxaqW04Cxgbco/HTC97kQGdDlOAQ6iEHet3ZvO0K
 NYeoRaIAYNV4GhYfgiGSbv2bJ6mEfhOzCWuXnGLBa7fVnsv/xF77hH62PLV0Xd1tsMY/2L634kU
 kGToLxjvbhFwNZ5T/lA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfX3tOzEXMQUbky
 DL3HS2EVkeds7EnkN11BHWSSQBSeIOPNUPN7fnXiwohdCQoQDVkLStvI78/diq8yyHtwTgavTRM
 JhUAyyTZXmKcDtpJ1e4g5ZO7LvhL9H4=
X-Proofpoint-ORIG-GUID: IjKTvZGZn2Cvker66jEiN0OTxXE2vVl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140164
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

VGhpcyBpcyBhIGZvbGxvdy11cCB0byB0aGUgcHJldmlvdXMgc3lzdGVtIGVtdWxhdGlvbiBzZXJp
ZXMgd2hpY2gKaW50cm9kdWNlZCBoZXgtbDJ2aWMuICBUaGUgZGV2aWNlIGltcGxlbWVudGF0aW9u
IGhhcyBiZWVuIHJld29ya2VkCmFuZCBzaG91bGQgYWRkcmVzcyB0aGUgZmVlZGJhY2sgZnJvbSBw
cmV2aW91cyB0aHJlYWRzLgoKQnJpYW4gQ2FpbiAoNik6CiAgdGFyZ2V0L2hleGFnb246IGluaXRp
YWxpemUgZGVmZXJyZWQgc3JlZy13cml0ZSB0ZW1wcyB0byBjdXJyZW50IHZhbHVlCiAgdGFyZ2V0
L2hleGFnb246IGZpeCBQQyBub3QgYWR2YW5jaW5nIGZvciBub24tQ09GIFRCLWVuZGluZyBwYWNr
ZXRzCiAgYml0b3BzLmg6IEFkZCBmaW5kX2ZpcnN0X2JpdDMyKCkKICBody9oZXhhZ29uOiBjb25u
ZWN0IGwydmljIGRldmljZQogIHRlc3RzL3F0ZXN0OiBhZGQgTDJWSUMgcXRlc3QKICB0ZXN0cy9m
dW5jdGlvbmFsL2hleGFnb246IGFkZCBhcmNoX3Rlc3RzIGZ1bmN0aW9uYWwgdGVzdAoKU2lkIE1h
bm5pbmcgKDEpOgogIGh3L2ludGM6IEFkZCBsMnZpYyBpbnRlcnJ1cHQgY29udHJvbGxlcgoKIE1B
SU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKwogZG9jcy9k
ZXZlbC9oZXhhZ29uLWwydmljLnJzdCAgICAgICAgICAgICAgICB8ICA1NSArKysKIGRvY3MvZGV2
ZWwvaW5kZXgtaW50ZXJuYWxzLnJzdCAgICAgICAgICAgICAgfCAgIDEgKwogaW5jbHVkZS9ody9o
ZXhhZ29uL2hleGFnb24uaCAgICAgICAgICAgICAgICB8ICAgMSArCiBpbmNsdWRlL2h3L2hleGFn
b24vaGV4YWdvbl9nbG9iYWxyZWcuaCAgICAgIHwgICA0ICsKIGluY2x1ZGUvaHcvaW50Yy9oZXgt
bDJ2aWMuaCAgICAgICAgICAgICAgICAgfCAgODcgKysrKwogaW5jbHVkZS9xZW11L2JpdG9wcy5o
ICAgICAgICAgICAgICAgICAgICAgICB8ICAzMCArLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAg
ICAgICAgICAgICAgICAgIHwgICAzICsKIGh3L2hleGFnb24vaGV4YWdvbl9kc3AuYyAgICAgICAg
ICAgICAgICAgICAgfCAgMjAgKwogaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jICAgICAg
ICAgICAgICB8ICA0MSArLQogaHcvaGV4YWdvbi92aXJ0LmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAyMiArCiBody9pbnRjL2hleC1sMnZpYy5jICAgICAgICAgICAgICAgICAgICAgICAg
IHwgNTExICsrKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAg
ICAgICAgICAgICAgfCAgMTQgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgICAg
ICAgICAgICAgfCAgMjEgKy0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAg
ICAgICAgfCAgNTYgKystCiB0ZXN0cy9xdGVzdC9sMnZpYy10ZXN0LmMgICAgICAgICAgICAgICAg
ICAgIHwgMjQyICsrKysrKysrKwogaHcvaGV4YWdvbi9LY29uZmlnICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMSArCiBody9pbnRjL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAzICsKIGh3L2ludGMvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDIgKwogaHcvaW50Yy90cmFjZS1ldmVudHMgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
NCArCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgIHwgICA1ICsK
IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCAgNjUgKysrCiB0
ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgIHwgICAxICsKIHRlc3Rz
L3F0ZXN0L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KIDI2IGZpbGVz
IGNoYW5nZWQsIDExNjggaW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZG9jcy9kZXZlbC9oZXhhZ29uLWwydmljLnJzdAogY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvaHcvaW50Yy9oZXgtbDJ2aWMuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2ludGMv
aGV4LWwydmljLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9sMnZpYy10ZXN0LmMK
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQK
IGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rl
c3RzLnB5CgotLSAKMi4zNC4xCgo=

