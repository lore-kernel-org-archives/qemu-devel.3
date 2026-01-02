Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0286FA3755
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 20:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vblVk-0003tp-IU; Fri, 02 Jan 2026 15:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVZ-0003rW-Qz
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:31 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVX-0002SV-OC
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:25 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6029W3o01002077
 for <qemu-devel@nongnu.org>; Fri, 2 Jan 2026 20:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=l1TVbKk+mCI
 EzQudKz22Bh/SC+MVr1qBQCS0QftOMA8=; b=Cphp14CxeBeKGMHsGMkyQJh440z
 i+QY3I60iC5kicVo0SYLxKh11YUwXUoZ42voOybj3Zk2iqvJN0StCXmQwoe9ePTt
 yAE5cwj+HxOG5MtTGvufuMcd8qx6LylKhO2VTRknh45B78IJro4TDRiWdszUMnbz
 2QDRISqP1ArR90EfWUmcq6rhbV/aGjFgtKqIS1yeynFkJtNFEcWBdR/rldEJxDuV
 o3wypg2Pv4m+i4brBy/02w6721SCSin5+eElmdGnubdFsoVctABUxZ8eWRianDeK
 1Wt7d70h71eFlylD7AItZmYC/HQeYYn6YmusD2XbTeNNOUUpyAGn5tJ9zvQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd2bb4se3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 20:12:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c337cde7e40so4014774a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 12:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767384739; x=1767989539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l1TVbKk+mCIEzQudKz22Bh/SC+MVr1qBQCS0QftOMA8=;
 b=ZDcZFZimR3wMvEthN4bFZr+drp5pB3Ry6vS6uGgx3KjnVWiyUshxJyp1opXJX29vsP
 324MwNmmsanDZigImFh4y5oQHtxGkLzN939kd03Eq0fwArQCzJc46Wfj/Y5ZeV+Xchc7
 Hti+Ck+7HS1xrSsoHXMzt1KMZpYv6iJNuVqLFMb+g7k8hXIOBG2T3+IvxljuMCHMEGjk
 nbjXVSETjL+kK14zjeQgTmOAwxSd1Y9KIJl83jJ2aQlQLj8nC0Qm5I4UGfvRSZv3YikH
 1T6PVvrqd7Lyem/MNu27tmdPSr572OWj6h+nKLiFk9qyK5HhclrP4jsOitWDjKZg4Ggc
 gsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767384739; x=1767989539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1TVbKk+mCIEzQudKz22Bh/SC+MVr1qBQCS0QftOMA8=;
 b=oHaIlv7g1YLEEuBaDrhWPKeN5D/mVys4xWKnG5utq1llRwLSGTH7a/gw0CSBkwsFle
 M+UF/OE7EUCVboJ2wuwsL/3NwBn57/xafJ7nkxohyqogjbIcHbUaBBbm5ByuoIbjDiDF
 RNy+IYM0q9ayPBEiE6v3mwlIVtJmemqJGN6WQ23UBc7p4w/eSAoYsC7vKWQ/yyh6k7vm
 LnO1WL2gG9DtVS2gd0OAHKIDEMCCvAA+pVMMqyT5gTF59rQdf/8n6Og5kQyW9Pl8Ddz5
 m6iscLamlOQsFTFOcQHNCCMtcTj2pVDaDkAcOYAwMLgWB6Hvjx/L2gEqwbC6GlqETVnu
 eYcw==
X-Gm-Message-State: AOJu0YyNA0YZ3jXXs42H8EWtEHjoRIUfo5hBktWUCTzwlH6+P1g+a4HA
 h0Ci7qtOEKbJ0RamQhin/GszwHosFfJDr9QPN9tjBuQ53BRAMLX/wMwdo5u1im4Nk8OUkCumsJb
 kEVN3UKV4S9yERPvTyahPOixiNPuUKFKe+N1IFmbjzhBILAtX1wUHXVxKnl9BmusBQg==
X-Gm-Gg: AY/fxX6PmQu2dRrpM2/I4HCTd0N+0ihYFIwctjj3wi3nqtJDaJ1wc14+HZs2m5oc7Xb
 utzhZmZih0k1rtN4m8dC1lGUwrCe2tI7d/TMhdG60B3VBTTJrA11X9DyMmqDPRNCUMyp5D93E/z
 dpw0jVtvRELvhzE8lc2ukscm4U2V/YwUuOrDlKb/58x2/hcT0b21CP3qly47pJro3zT7imSHOuF
 58SRuEln+NtueLIuSJpbNKvetcc1CSS8DpfkWQPLe4MQxXX1YDWjzUvwITr9QyNfOha50oc/wth
 gY49XVa8NpI0rIX487X7iZIF2C9zH0RJ+HbNv8nUStPViflXycENpo1/JNPTlcQhuQU0rVy4Xz6
 XUcKYTFfVC9J9A9XsntZBUPeIDH0lSXHPgmeK7YbufxNQj2QaX5Wl7yQaGQ==
X-Received: by 2002:a05:7300:7994:b0:2b0:59da:f794 with SMTP id
 5a478bee46e88-2b05ec745ddmr32008592eec.24.1767384739174; 
 Fri, 02 Jan 2026 12:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfzBeAva+Q7eXjZbua0T676SH++EDMyCCcpQm2xGbpUZK2726EzynM9Btp415IUSuvlA1hPw==
X-Received: by 2002:a05:7300:7994:b0:2b0:59da:f794 with SMTP id
 5a478bee46e88-2b05ec745ddmr32008579eec.24.1767384738609; 
 Fri, 02 Jan 2026 12:12:18 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b140c42e7esm1794621eec.22.2026.01.02.12.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 12:12:18 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com
Subject: [PULL 0/9] hex queue
Date: Fri,  2 Jan 2026 12:11:56 -0800
Message-Id: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 2GgNYR-c8wcaK0ZpSU5PkYMJWre2UmTA
X-Proofpoint-ORIG-GUID: 2GgNYR-c8wcaK0ZpSU5PkYMJWre2UmTA
X-Authority-Analysis: v=2.4 cv=dMKrWeZb c=1 sm=1 tr=0 ts=695826a4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=h-5Hz7uf12n3Wuq6EVEA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4MSBTYWx0ZWRfXy9KpexfJ1bfe
 SCW+5rYhaH4A5G0bzaiV36JoM+hawcE3U0/pXlb8Sy5Ku0rJEtqKqV3uAw5r2jxC8k8yCsRYmLa
 /YfneplvG7i7AxOO0PNHtWzHlXAqPNuE6WzWdPYrXWwztivVy53uM8x30ODvQ9vK9Auawwaf6iz
 HbOQMViliLMET4daoQdtZ1HD1jA7HLeNI3gLZfCgtun1oFz6k4Gr9A29WVLbNpdGKs/rppwnFzA
 3G2+t8TWA8GMBra4L+hzGwKYDkaJVsqYKfMrgmN2tDXzg2KNWnsKiuNITf9QYm2K8a02xk/GRES
 fXt4D18JBR6WsvOlv13NOqU0uFbCLAWber1go3bxGtq6a+N6R++aL6aZgsjZWpoLnKT5+EMNwqv
 gP0n8tdqhlQT2DNBZYQhdHd2RggJIgmo7toSbuRCIYzPxgCKTB+laXL3hlm36PJlH+ec5EmX0BJ
 nYT+QYdtHbmssq/aScQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2NjdlMWZmZjg3ODMyNmMzNWM3ZjUx
NDYwNzJlNjBhNjNhOWE0MWM4OgoKICBNZXJnZSB0YWcgJ2h3LW1pc2MtMjAyNTEyMzAnIG9mIGh0
dHBzOi8vZ2l0aHViLmNvbS9waGlsbWQvcWVtdSBpbnRvIHN0YWdpbmcgKDIwMjUtMTItMzEgMTY6
NDQ6MTcgKzExMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoKCiAg
aHR0cHM6Ly9naXRodWIuY29tL3F1aWMvcWVtdSB0YWdzL3B1bGwtaGV4LTIwMjYwMTAyCgpmb3Ig
eW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gMTU3MjJjNzc0YWIyZmE2OTA0NDY0Y2Q1MzFiYzEx
MjBkOTU1Mzg5NjoKCiAgSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIHMvbG9nX3dyaXRlL2dlbl93
cml0ZSAoMjAyNS0xMi0zMSAyMjo1Nzo0NCAtMDYwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQnlwYXNzIHBhY2tldCBj
b21taXQgZm9yIGltcGxpY2l0IHVzciB3cml0ZTsgY2xlYW51cAoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUYXlsb3IgU2lt
cHNvbiAoOSk6CiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBSZW1vdmUgZ2VuX3RjZ19m
dW5jX3RhYmxlLnB5CiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBBZGQgcGt0X25lZWRf
Y29tbWl0IGFyZ3VtZW50IHRvIGFyY2hfZnBvcF9lbmQKICAgICAgSGV4YWdvbiAodGFyZ2V0L2hl
eGFnb24pIEltcGxpY2l0IHdyaXRlcyB0byBVU1IgZG9uJ3QgZm9yY2UgcGFja2V0IGNvbW1pdAog
ICAgICBIZXhhZ29uICh0ZXN0cy90Y2cvaGV4YWdvbikgQWRkIHRlc3QgZm9yIFVTUiBjaGFuZ2Vz
IGluIHBhY2tldAogICAgICBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgYW5hbHl6ZSBhbGwgcmVh
ZHMgYmVmb3JlIHdyaXRlcwogICAgICBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgUmVtb3ZlIGdl
bl9sb2dfcmVnX3dyaXRlCiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBzL2dlbl9sb2df
cHJlZF93cml0ZS9nZW5fcHJlZF93cml0ZQogICAgICBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikg
cy9nZW5fbG9nX3ZyZWdfd3JpdGUvZ2VuX3ZyZWdfd3JpdGUKICAgICAgSGV4YWdvbiAodGFyZ2V0
L2hleGFnb24pIHMvbG9nX3dyaXRlL2dlbl93cml0ZQoKIHRhcmdldC9oZXhhZ29uL2FyY2guaCAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAg
ICAgICAgICAgICAgICAgICAgfCAxMjUgKysrKysrLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5w
dHIuaCAgICAgICAgICAgICAgICAgICAgIHwgICAzICstCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIu
aCAgICAgICAgICAgICAgICAgICAgIHwgMTE0ICsrKysrLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuaCAgICAgICAgICAgICAgICAgIHwgICAxICsKIHRhcmdldC9oZXhhZ29uL2FyY2gu
YyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKy0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5j
ICAgICAgICAgICAgICAgICAgICAgfCAgOTIgKysrKy0tLS0tCiB0YXJnZXQvaGV4YWdvbi9pZGVm
LXBhcnNlci9wYXJzZXItaGVscGVycy5jIHwgICA0ICstCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYyAgICAgICAgICAgICAgICAgIHwgMjg3ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0K
IHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAgICAgICAgfCAgNTMgKysrLS0K
IHRlc3RzL3RjZy9oZXhhZ29uL3Vzci5jICAgICAgICAgICAgICAgICAgICAgfCAgNTQgKysrKysr
CiB0YXJnZXQvaGV4YWdvbi9SRUFETUUgICAgICAgICAgICAgICAgICAgICAgIHwgIDExICstCiB0
YXJnZXQvaGV4YWdvbi9nZW5fYW5hbHl6ZV9mdW5jcy5weSAgICAgICAgIHwgICA0ICsKIHRhcmdl
dC9oZXhhZ29uL2dlbl9oZWxwZXJfZnVuY3MucHkgICAgICAgICAgfCAgIDggKy0KIHRhcmdldC9o
ZXhhZ29uL2dlbl90Y2dfZnVuY190YWJsZS5weSAgICAgICAgfCAgNjYgLS0tLS0tLQogdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weSAgICAgICAgICAgICB8ICAgNyArLQogdGFyZ2V0L2hl
eGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgICAgICAgICB8ICA1NiArKystLS0KIHRhcmdldC9o
ZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgfCAgMTAgLQogMTggZmlsZXMgY2hh
bmdlZCwgNDcyIGluc2VydGlvbnMoKyksIDQyOCBkZWxldGlvbnMoLSkKIGRlbGV0ZSBtb2RlIDEw
MDc1NSB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2Z1bmNfdGFibGUucHkK

