Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B418DE94100
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNKW-000435-Gl; Mon, 29 Dec 2025 19:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFy-00081s-39
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:34 -0500
Received: from p-east2-cluster1-host9-snip4-10.eps.apple.com ([57.103.76.113]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFw-00048f-MJ
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:33 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 7D2121800475; Tue, 30 Dec 2025 00:06:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=HvfpbIRIHkux3GwMoa81UjW64yTUwu8WPNZESmVNycM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=G3RmAwKapFR1oElMGkW6feKRDlJZoLgKQsf54dYMxDIVRuqU5HBwgZMRN2RFaeNMar6YO8pamAw4Cd+DLSdNL23hFVf/ql2Se5X+/Ng4gk5AvhJEEiwOIBJb1FFSK+5zIsLiqcee+6ND2+hug/bSMUR3roCKFfF+8WIrLc7MYKuG1oh9EdvMuG9K7FN7awyIyIWA82loKCAeJWFlJS0pvbLM4O1iQUK83lA8uJJ65RjzGBh80xe9KWJvlOUbfhpjRq3eSLCwrgL+rhnQVpcDDt9wnTspZLF4vxD9+p1+27oLFZYNSEQTtJrzMQ5gbtyHw5b3Zs4/tsreFAAovVrmtw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 A5A1318010C3; Tue, 30 Dec 2025 00:06:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 28/28] MAINTAINERS: update the list of maintained files
 for WHPX
Date: Tue, 30 Dec 2025 01:04:00 +0100
Message-ID: <20251230000401.72124-29-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=NdXrFmD4 c=1 sm=1 tr=0 ts=69531786 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=t-S863UTctjxRPX8:21 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=hdCJvu6vi-O6ykQZt0QA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX8RYxNZmFulY4
 orx86ryqet9Cridc6VzJa1z76p2TPv78WcZ9n1I0QdsYyWWXksAYAbHwNs/ueEmfk0TbGmknxCG
 eWehe3FUG3+myzDJosf3MnM93F+mkRnik92qkOsOhv5P3bJ/YhgT3q65k9qKtWAmB8x1Hc5oNwz
 K0vq3Ss2V8JA5eJQhXMkkRZ/m7smAfPLm2xxc7KKCmkuDeSxXruc43cr0KKYm2WpXVlSvE2Jxe6
 QIH32VzHUb+n1Vf9ENbItjfCRfg15xQJtacPLIkpytzy7fMI3OJL3TmQW3ukyZn9kwFwr2SDVIH
 U0VORBP+rcHIM+phfpS
X-Proofpoint-ORIG-GUID: NHOVVDnK-iPcUFZzjqKY2mjSEVgEgdAl
X-Proofpoint-GUID: NHOVVDnK-iPcUFZzjqKY2mjSEVgEgdAl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAABVh6ISKBKxx4e1RLQ1oDVSKVBANGY3Q7HZjg+UCNxJ05VplWYSzZSk1lUzfyygnu4uRV0B57leNsTO6l+7fE3vrXkinKXfnF8mfRGX8NkDv35unNziJICaLccMgx2lw0oW87iUyOpqmhJ1yDR886DVcCftT7f/YhQknJiMj5Vt/q+ujQs90RXfIIEn2zt2VohpFopY3gK+utgWRjTtyJ/oGWipB9p002ZdEJQhgI/V5lrpHkDZLs+RSC+qYMntQeXeqpr+k134ENo8Wm40tXKvNV1nNvocgbQyluL+5S8oZSWkBfZw25B55TSZEU/IBW43YUS+xAM1mQYhHV94rUaXT6BVJS/Z5lkOSYhQ1/Nce2JorPKP3QOVxBt02MvLRbMCHLi8u6NYE4iXNX0rxY+wct9xNsf9Pp30u9L0pPRtBxAjD0c3vFHRGBLCWIawZEUIiCirYfMk2i9DratEBRv0zQJmfmBaSuxeafJQIUfASX8jXyrPzAjCBzajZoHwa2RPxRGmpYMeC0TiiNdOhNIsxKaApq6piFdNk9K5EfRUcJnxD+2t2plvLSGFz4jEE49lrJ+WdDOusTiQi6i8nlbwqQDkqtzoGRIny/YT1yYgVJfd1NoaWyG9vIVa85JtexgyqawzafFjoPa/M2Ua0OKEQ9OdkWgGytgdl5SWxWf/ZczJS3yUtiglsVK21QshO6IG4iudX9fobuNEdaZYo8IgSNWEwswpJe0c8UrVtTIYRTqVEeTy75hMYKaEvtd5BIl0bMsRVpS89nEURU24tlisq3LbeQtc8JuwhNkroiQ/ff46fjeESYHaGuiVCjPRDXllQT6OvzMOKFkrpfD/juyRYUOK2n7AFJ55enyFvGjnmiE3XxM2+6YLQ9hPvWBiYVfz0Lcskjz9ktp9MZ1ksK8re+8YgEJE4uATGlt3IYXVSyKUGuQnEw/I6nwNet+DBsVvBCLLdnsOUlI
Received-SPF: pass client-ip=57.103.76.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add arm64-specific files.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d84f141cc..7ac1efd904 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -552,6 +552,8 @@ M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: accel/whpx/
 F: target/i386/whpx/
+F: target/arm/whpx/
+F: hw/intc/arm_gicv3_whpx.c
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
-- 
2.50.1 (Apple Git-155)


