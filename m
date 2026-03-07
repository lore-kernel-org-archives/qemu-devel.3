Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4958F55101
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 16:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyuPu-0004dc-UZ; Sat, 07 Mar 2026 11:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyuPr-0004Z1-Tl
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 11:22:12 -0500
Received: from p-east2-cluster6-host2-snip4-10.eps.apple.com ([57.103.76.191]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyuPp-00084I-F0
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 11:22:11 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPS id
 CFB1E1800520; Sat,  7 Mar 2026 16:22:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772900527; x=1775492527;
 bh=Rwu6a4GQR/Fafkutd6iRYbGks+rvieci/uf7WVSt/og=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=ezL4QvneMwHNUzmboZrbAEudwwdk1i372+KQc6qxqhSJaZxqIYKTEPrAr683m2OVme+ZNFFJIyVL03sDy1Kpyb71zSYtQu9PoZoc4jfh2uiDtLbH++Jr3CbU0lWc90NQl1eUcZ5JmjwRe1oqWVvVBlNx6mW4J7D0C6T97moBe7bKjz2Iet4wG1SdmCkTcfxBdBtO8BZTipqPSt4Qd4gLllunpJJsU/kg2cbfGY+R6kPnhU+e/KdYlSY/1B3wNKPB4liDYdzU6pKjlvnT7FH37ETcAK+nNm4vJr43G7HEDZpb4/LIhU6UfQYHqF0AkmIMb3bQGaBbS9O64MBpmfPDrA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPSA id
 993051800188; Sat,  7 Mar 2026 16:22:01 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v18 05/13] hw/arm, target/arm: nested virtualisation on HVF
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <d2bd5f90-a0f7-490e-b735-43442f41c679@linaro.org>
Date: Sat, 7 Mar 2026 17:21:49 +0100
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8185464-F6BB-4A50-BE57-EFB2A7F777F1@unpredictable.fr>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
 <20260307153143.76893-6-mohamed@unpredictable.fr>
 <d2bd5f90-a0f7-490e-b735-43442f41c679@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=dr/Wylg4 c=1 sm=1 tr=0 ts=69ac50ad
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=xsIae2ODNr0s6XOKyHUA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE1NSBTYWx0ZWRfXyVUNmDK6lCdh
 0stW8wXnRvC0fq1+nFFlWJXXvQT2V7x2Eh5f0irLINMM0Vn2YjQtJHkCd5J6B/YpqsTTUBoSFDP
 ucW5PZtV1OqSyiV7hbqRfz2HnwP2rS1PfACe/XJy1Ia/mgDuz3JCwvZoU8ifDuwDci9P+3ZJ5EE
 JNH8hr+wTCrkXOp7tyGQVn77UhbNG9w80jodoygrimCjTuwxMxC7r6DtoclAxY8Ic6QR/+L+r5p
 fA2Y2qF+2eatnpPtSWu/h4PD040qYMuvU1TBROOLEchekzoR4o3hAfdUSLmxOq6G0FHSnE+ptGy
 PitZbRwddnHuf+c0Fu2zouvlbY8z04wr+S4v/UujNnfkyAdsAgUiH5ol/8AXv0=
X-Proofpoint-ORIG-GUID: wcwzsuJfLUwPrRPO0lg7XWgpqHKwzdx2
X-Proofpoint-GUID: wcwzsuJfLUwPrRPO0lg7XWgpqHKwzdx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 clxscore=1030 bulkscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070155
X-JNJ: AAAAAAABhovdkAHzJ+nXTrhBLVtt/wra4q+bFN4ZtFqMvbySEE/ZE7HsNtf4IrYVsnh2vYxOhIjOnntBiWxna9QlXE9ediDQ8U9q35vXMt+qR5LZBSjbi83lhKF7GTfqhCgsH5qeTy78Rboxmn5LHt34SfOk5vxKNtviLZg9P/AYnbMtVD927PUEwi8ejvpca9aYr/kgXBTbgNmN7RtX3QtQ2hqidRd2SS1EVL8fBJfqv+ycBxBlM4azdq+taO8gorAxTImSbf5jS3cFVN1iB+72Q6+hL9yIJDUw4IO+mXo/RCFkktiYxSfcSf0XElwG0nWebwfWk2B6djzbJFqyIKFnbRDFpYTchfONc1BvVG3L5GnFClt+loi8sYKOGGQxUcsgACQuajIZJXnVvipFQS5zxCkluzyMCBvgpkWGtO4LIn40EPuGPRgU5LrJ2FI5FFGwk2g9ROMY8xiki3Sjkn/+3f/79YuhkAmozL0ZV1mK6y6tWGBlWpMkZYQP+4xFcnA+knmn3Lwmnpi32jH4KBHws+7STkJj1DTwJOjPO90gE7FCCgr7pslAN+xI8ropWtC5q489JsECsi3fi1FwaDutt706o4aSA6oS/EhPkdOCOiyxuXgzvYqeMPGscd5Ve+Fp/dbOH8O6yB+ydWfw+eGXZPMrDzUsJRvBRBfBjMCc+Lal333INs94lKjx5sgycFAmZ4B4KbEJD4GD+IVLnpS+SPQoQUH+
Received-SPF: pass client-ip=57.103.76.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 7. Mar 2026, at 16:48, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 7/3/26 16:31, Mohamed Mediouni wrote:
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  accel/hvf/hvf-all.c    |  1 +
>>  accel/stubs/hvf-stub.c |  1 +
>>  hw/arm/virt.c          |  5 +++++
>>  include/system/hvf.h   |  5 +++++
>>  target/arm/hvf/hvf.c   | 42 =
++++++++++++++++++++++++++++++++++++++++--
>>  5 files changed, 52 insertions(+), 2 deletions(-)
>=20
>=20
>> diff --git a/include/system/hvf.h b/include/system/hvf.h
>> index dc8da85979..0f0632f7ae 100644
>> --- a/include/system/hvf.h
>> +++ b/include/system/hvf.h
>> @@ -28,9 +28,14 @@ extern bool hvf_allowed;
>>  #define hvf_enabled() (hvf_allowed)
>>  extern bool hvf_kernel_irqchip;
>>  #define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
>> +extern bool hvf_nested_virt;
>> +#define hvf_nested_virt_enabled()  (hvf_nested_virt)
>> +#define hvf_nested_virt_enable(enable) hvf_nested_virt =3D enable
>=20
> Unsafe macro. Better expose the method and add a stub.
>=20
Does this look saner? If so can send a rev with it=E2=80=A6

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 1c1437b467..66c3b48608 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -26,6 +26,10 @@ bool hvf_allowed;
 bool hvf_kernel_irqchip;
 bool hvf_nested_virt;
=20
+void hvf_nested_virt_enable(bool nested_virt) {
+    hvf_nested_virt =3D nested_virt;
+}
+
 const char *hvf_return_string(hv_return_t ret)
 {
     switch (ret) {
diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
index cec1cbb056..dc365c5307 100644
--- a/accel/stubs/hvf-stub.c
+++ b/accel/stubs/hvf-stub.c
@@ -12,3 +12,12 @@
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
 bool hvf_nested_virt;
+
+void hvf_nested_virt_enable(bool nested_virt) {
+    /*
+     * This is called unconditionally from hw/arm/virt.c
+     * because we don't know if HVF is going to be used
+     * as that step of initialisation happens later.
+     * As such, do nothing here instead of marking as unreachable.
+     */
+}
diff --git a/include/system/hvf.h b/include/system/hvf.h
index 0f0632f7ae..a961df8b95 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -30,14 +30,14 @@ extern bool hvf_kernel_irqchip;
 #define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
 extern bool hvf_nested_virt;
 #define hvf_nested_virt_enabled()  (hvf_nested_virt)
-#define hvf_nested_virt_enable(enable) hvf_nested_virt =3D enable
 #else /* !CONFIG_HVF_IS_POSSIBLE */
 #define hvf_enabled() 0
 #define hvf_irqchip_in_kernel() 0
 #define hvf_nested_virt_enabled() 0
-#define hvf_nested_virt_enable(enable) 0
 #endif /* !CONFIG_HVF_IS_POSSIBLE */
=20
+void hvf_nested_virt_enable(bool nested_virt);
+
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
=20
 typedef struct HVFState HVFState;

>>  #else /* !CONFIG_HVF_IS_POSSIBLE */
>>  #define hvf_enabled() 0
>>  #define hvf_irqchip_in_kernel() 0
>> +#define hvf_nested_virt_enabled() 0
>> +#define hvf_nested_virt_enable(enable) 0
>>  #endif /* !CONFIG_HVF_IS_POSSIBLE */
>=20
>=20


