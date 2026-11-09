Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29126606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=1MJlnSZ3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDS2-0005nT-98; Sun, 08 Nov 2026 19:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRt-0005iT-SB
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:26 -0500
Received: from ci-2003f-snip6-11.eps.apple.com ([2a01:b747:3005:200::3f]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRq-0006Lw-Oc
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:25 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 7F52218007E4; Mon, 09 Nov 2026 00:41:16 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-91c9-71d3-a49e-7ada854a5799
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0YZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeWhoGXRhYFVYJdx5cAEsdVwRUH1MSVR0dC0VVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184877; x=1825720877;
 bh=zo8VHkRvOxPsN0lBHLgB1+jjjExS/dOPgbaOWnVL5Os=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=1MJlnSZ36shkWPmpUd8oGTMw8zm1eQSu0dDQ/q423iUXGzWUFaJEaqOYXC3neRgcE96jfL1EEJNsxUehM7Dcmadp+tvBNZbc/7gYBRyWT1jH5FvVQygA/VN4x6SZJk5HY+rq6GBTRdWgzNT6haS4kVQmK0hcU+NOlRIqI7LNX5YCMGYYrvE9NgazPfhJBr1iUrf6uobCDfnf/AvQCAYzM66+h16o85dV1zg9tcHpgrOZ/rec1CJZ69Zl8HlHCJi4F9XBWDDXXxhiuf991BrNuhu647bP+Y7iJh5nzY7dAfV11EorV5/ZjButCppDQDA0Xr0ULeIHI3SwWyZYaho8jA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 CEB4F18000B6; Mon, 09 Nov 2026 00:41:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org
Subject: [PULL 06/13] whpx: i386: make nested virtualisation init failure
 non-fatal
Date: Sun,  8 Nov 2026 17:41:01 -0700
Message-ID: <20261109004108.85808-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: khICCEFhy0Wiw2h_IOi8XmZ_BvcuWZvp
X-Authority-Info-Out: v=2.4 cv=LbwxKzfi c=1 sm=1 tr=0 ts=6af116ac
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p5XUOwc6s_shZ6Vv324A:9
X-Proofpoint-GUID: khICCEFhy0Wiw2h_IOi8XmZ_BvcuWZvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfX8njWqmqEIWBq
 ETSiRZc7nggMQrUwYrQym9YZ1hFPu+5aSFEPid+jQKZN1OzCoSnNxcoh1of5w3howmnGQx/QH4u
 7SjyyHpJHGZ8ErGXQLxyNei9gfGQFyYkNrnSWq14b+/9S4Qy7o4IB6zwTRrDmn86wNoYIkXN1nl
 +lVGElxprbg+xQ/PBs3wzp8HoVHalRwciWJVg+h3PGEzu0H1+nhDWW6YWCmuZpxWpJpEsKVKFF5
 /IeuonxmURiDIi0LzI2NJ0GGPzB4KdULV/kd4+qYVirrsdoNqW8yef+ZtFjR4DQWo4G2XavLIPS
 4KeW7F+i5dh/nbDKaRB8cKIn2NW2i9OdoBqh7h3rkGUJDItcYsRWvLdE8jhz4Q=
X-JNJ: AAAAAAABobQgE5/GvvAaZt9X3aVAqqKaP+p6uLLYMsAhdA75/UrDWWQQubqB32hqOIQXYN
 5vpGpszOKmzqwlKYMMZNCQ/5tjvUYGaQnLPge63hzq2ueL6NqQBy/w4igJWF+oYIh4p9Iq
 uL9ZxoUkRYgVyHSmW4aqMIkIHX0AwkNI7OF4LwpQCdfqF1IyMixmLZQCEMvEyWsg9cFlbe
 KjSwJfjB+Rv8Lj2f1UKFZl7kIuh6txRQ+LrdMYm9QSOG/iyiXVWlSorLx95dBOhCzeK2yy
 ZA3I3uy7/KSHF11nE73C177hwAeZGoPDMb3jC9R9l/Hu/18SiKUuPZuwqMxAGrOx35TA3c
 NRsQm9TzxIh2/CMXWQypIukVkPBmjujH07iGq5y8HdQCJzT2pKSLmU8vb38DSVSK2D8aOl
 1SOoEDolfh9eJYdpOuU24nrbTOsAS/eoOKIuN3j7JcKUuTNsvKWlKJakxdTWIsgMfN0Mmo
 EAWYgUwAlf2gn2NVh/3HaPpctB92Eeq7etQetMTeRr2qmvPFzI+ZV5jBN/UBTjAyIoa2U+
 m648GJmD4Lf0aaTsymm3C0oXKWWWbwSl/noK+roEpdqKA/ijfT8UO5dxQ1F/WPIG1r6xN3
 b8+tMuY8F3axasDBpyxnn3g80ybqFHa1ZbNEl8P/IV+w2DlB7zNRm3a4nFYOflsx+wJvqQ
 Maqr4DQ36UpJb8Veuu910wJFemDjUIo0xhjihm/KHLjWVi1E/83uy710/KQ/J3d31VhaIj
 CsqBR5JoRbKl2B4jZHz8rFDs5sEZ7R5U1+rGIoi3VioxPEHnLDgjNv3JVXf80Ax6xehC9N
 NPEp
Received-SPF: pass client-ip=2a01:b747:3005:200::3f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On some CPUs too old for Windows 11 (Skylake) support but running
it anyway, WHP advertises nested virt despite it
being unavailable.

As such, make failures to initialise nested virt even when advertised
non-fatal.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index a72382c7dd..7e418f1c91 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3263,9 +3263,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             &prop,
             sizeof(WHV_PARTITION_PROPERTY));
             if (FAILED(hr)) {
-                error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
-                ret = -EINVAL;
-                goto error;
+                warn_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
         }
     }
 
-- 
2.54.0 (Apple Git-157)


