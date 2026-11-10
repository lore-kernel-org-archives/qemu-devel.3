Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0809606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mOMRQ+mV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQl9i-0004ww-Bu; Tue, 10 Nov 2026 07:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8i-0004SO-Tg
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8e-0006bi-7p
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:51 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so12925515e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 04:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794314385; x=1794919185; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vljIAdkLgSSCSZRHPZJWBNwo7eqzG0bIyrMigVuydgw=;
 b=mOMRQ+mVLqKROKivUAbIVdAaZyXnJqCEXKEn+gemA1KqDXAJ9AmZ1l2Yl6O6cCpgKZ
 vl6Sa6yiAIwFfX5B2JPn/gFQCgM+LBLB9PfymcCqWdceSuH3oifp48I/+2UOLqFRm17V
 XN3NHpqZM3zs3CPMGgXsPpIBbzFKhYjkLs2QsR12c0uoZT9XlfCi0Wk9suKNQBzuhc6y
 66YdpKuhrWWCaWRNY7HGKtStITvtpH42AFxQ+RXkloMm1CsVQCaxIVAQbKTeXzaHZ8Rq
 qi4G/GtLJWDau2ArA6c3IGMKt797Hhc/8oZS9FWOyIKWd//RzG1z3CeBNtyTbde6nr44
 EAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794314385; x=1794919185;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vljIAdkLgSSCSZRHPZJWBNwo7eqzG0bIyrMigVuydgw=;
 b=0G2xgGSxGY6HTR78ljLtLB19WMXiZamkcDfCCqA+YSnZ39BVDcRSVhpfYKj88Hh/jr
 bsiRb0zI4mhTRzS5rd670JRC2Qc1XXGy9UCNTgbL65wY5JRvoh2FVsuBS04aUAogsw1c
 We/M1LNd/l3iqPjHFZ/WQEYFlGZ2KaWGBZVDWybFPqglo96myYAvpBMdCGFTL/IRRHKi
 vhLCwFDlhHk7/JOXQ4LqmcCfRJmWy0nxqTednP3QMafUXBqRNP5rnvtcSAdVoihCH2RL
 FtiFe0MQAMHaXaMCyoaqP76iDclsXnID7oDAXpCzWIdhgFuGTzrWvvG817JaJfOvDGpf
 liYQ==
X-Gm-Message-State: APuU4Z+D/jMr4Jz6AYC1Anm7RG3E3RNSyd9MLm1WAVwxldo+QmItRJJu
 0mH/79vMrYHA5xujms3idHFvuBhcIA3dNFF7Zrn2qX8ISOd2Bp+3DTy7yGBWUlRs42Y=
X-Gm-Gg: AYBFou1M4ATnSRgiA8xPKkL7GM0hXGjolzPD0bgGD9aVyysYlI1aga9GXgDLpnPVFth
 j36cDxm2irteuqLvQPgd4CAx4iV8+PPDXRhI4Uy+RmsvoOELaJeR8HMnXxLKssqj0Lqe/RlqDkm
 v3ddi1jVEy+wz0r/EV10uAgxOkDmY5ThzUsGtVFm1so5UsxPlIHlaOsC3jWp3h5p8hOE0AkBRrg
 hICfunriYR8JZTrKClKX9+SBSsgMn7A5PhaFbOyDQ4Jci4U/RMckHKOZ/3ztKiIZaR6ItSn/3lT
 xcqJ6ONaylQY3q3PAwUlGczBUEbeXVU+Tc53dsyQ4Yi0FYuEw/sfsZ/gVKGFiQviSLYK5ORLTJQ
 jlYm940/FpPhDIUFXE23qKm7s0LsFXkZON0g2Mp4+aY75ird5CgFvVZWtoWMqIIp1aaGYBDp6VQ
 /LjEQenBsAjWiZ+ZvqGv05xlBAiJQGPwGctj1lE8eZO6Fcw2V9/6Qo70oJH7A3I1uFly53oUyHN
 hj8s6peg9FTPNuXzwBSIza6jJQCt+ztCeuZdu9HlNbcmNOkqqQ8BWj20H6tGn5TMkC7tg09aJzX
 WeYBNP84vUbxwnolYYH5GpMFuulPb8MSAUbvsi0BBuTDe0atClrxDUc2cgy6KW3/Oh+9cX88fhG
 ntprRJUi48Ty+3YWIA//TDEL4+Q2MZlct8VDcitqxWReW5kL8RMnCSKlI+XaWassJg4jSU7jORA
 d2TkUXjv4dYlhzVn5vwPTlVXmgfgyn39DwoPCyO4OqOahz+UCnk+oZHI87KIj+dIE=
X-Received: by 2002:a05:600c:6098:b0:4a1:da58:1ee with SMTP id
 5b1f17b1804b1-4ba02358e34mr43726305e9.31.1794314385081; 
 Tue, 10 Nov 2026 04:39:45 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0233e5d7sm47638475e9.1.2026.11.10.04.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:39:44 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 14:39:30 +0200
Subject: [PATCH v2 1/6] virtio-snd: convert virtio_error to error_report
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v2-1-d5b654217676@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4217;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=pz69gFiFH0eYhwxowWXjkndE5bzKGEn0L87jqHFcBZI=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8xCOTKoQlg46N/C/49+tfk5v0ShSUQ1sqWIl1
 FjHzA6cmdGJAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavMQjhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdCAZA//YC/mmxhhhOoVUpv8J2fkqJL77zqYTk4
 HqDTudpHhp6R4HRqAS31K9R25vvSEVHfScWBwL6KwwhDeWtGiXfeqDtbvYIPrVVSImpawMUQYC+
 C50k1lWuJ/MojYKtc74oA1UKhEQQZsEJWEEZU6MgvPORCUWvDfL4zPAG2jWtCcjCNli2b/S3nOQ
 IwtQhqrShwFBAql7HD0vDjLL8PK+RpFL5vXnD13VxRQDQXBldfMi4MvIX345aEkpKv4w4Q/zA1F
 ikzxR+wlYtsHDB+86zYa3IEuOHZxsBhiI5e+SOxPfGtkXh53K/+Crg8p4gez0hesPS4wtCJRWdQ
 Aara9ibM3r/riVDCnd9hLsVTnHQSqsew9IreLqlDVecE+FDlHVe8ACjBAaWIgkvSx0fd+UEyBsm
 YqkWNUii0lwNamZKf6ktsuKNaoD+foOfKxe+0MlMze8+ojBQav9S+y4OrS8IP8CEe1BV70bFAgB
 gbXirU42tBV6S3rLlHkQuRbFSHtWclYJvcI47i8OLJCQj/UFUeOOIrxzGxmFxw+UC4DERmtPknT
 7e+WCaSeRFJugiIKiOAP686ZJOOwBjbtuWpdAHrJcbLS0QZqxRkRGdcAPCoHTUE31g0h9surp1p
 PP3vnHSaKnU37N7MJigMtqouvvoEZ546o1eJRy0Tuq/uQvrAJzSQ=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio_error() also signals a RESET, which is not what we want: we want
the guest driver to read the VIRTIO_SND_S_BAD_MSG response.

If a guest sends an invalid command and we do virtio_error() and reply
with a BAD_MSG response, the guest needs to detect the device reset
otherwise it hangs forever waiting for the response.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index fb22d79949..bed36203f2 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -298,8 +298,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (!stream) {
-        virtio_error(VIRTIO_DEVICE(s), "invalid stream id: %"PRIu32,
-                     stream_id);
+        error_report("%s invalid stream id: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, stream_id);
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
@@ -310,8 +310,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     case VIRTIO_SND_PCM_STATE_RELEASED:
         break;
     default:
-        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                     stream->state);
+        error_report("%s unexpected stream state in %s: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
@@ -535,8 +535,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     case VIRTIO_SND_PCM_STATE_RELEASED:
         break;
     default:
-        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                     stream->state);
+        error_report("%s unexpected stream state in %s: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
@@ -624,8 +624,8 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         case VIRTIO_SND_PCM_STATE_STOPPED:
             break;
         default:
-            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                         stream->state);
+            error_report("%s unexpected stream state in %s start: %"PRIu32,
+                         VIRTIO_DEVICE(s)->name, __func__, stream->state);
             return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         }
 
@@ -635,7 +635,8 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         case VIRTIO_SND_PCM_STATE_STARTED:
             break;
         default:
-            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
+            error_report("%s unexpected stream state in %s stop: %"PRIu32,
+                         VIRTIO_DEVICE(s)->name, __func__,
                          stream->state);
             return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         }
@@ -724,10 +725,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
     trace_virtio_snd_handle_pcm_release(stream_id);
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
-        error_report("already released stream %"PRIu32, stream_id);
-        virtio_error(VIRTIO_DEVICE(s),
-                     "already released stream %"PRIu32,
-                     stream_id);
+        error_report("%s already released stream %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, stream_id);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
@@ -737,8 +736,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
     case VIRTIO_SND_PCM_STATE_STOPPED:
         break;
     default:
-        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                     stream->state);
+        error_report("%s unexpected stream state in %s: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }

-- 
2.56.0


