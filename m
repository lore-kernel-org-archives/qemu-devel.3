Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5D1606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w0hBJ39z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLn4p-0006lg-He; Tue, 27 Oct 2026 15:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn4i-0006lB-GM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:12 -0400
Received: from mail-dy2-x0b.google.com ([2607:f8b0:4864:36::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn4g-0003rw-84
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:12 -0400
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-3535a54c09bso162528eec.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130189; x=1793734989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A+jCT1srzkiU114lsj7BnmbRqKFkNb+yMqW70UM/kqc=;
 b=w0hBJ39zldRcx6YkBu72GjUVjKk5CS76MMx+h0HaDx7oBBE1GrOjBje+mgYoQ2UYO8
 QbWDkxdngRVUmvpQlkNcQaYdiQT6M6pF4ds4/1Ti//fftqCWVOZpDaDxaEWegPDGwiud
 9tti4CYxFuNlvAg4JjLT2y0puku9D1gn60DXMNgIg0iYaFacGQgOpVxanJ1VRCzAGy1g
 hTccj3y2Bpg+o5wAlBED+STnJWLnS6E874Yu0Tncz/5vGsZvzq49trgX+FwFrWy0w1H8
 v6gRGO0QU8FVkM4azv7u0w6ihnaSgV5THHAqKJEFd0g0xfBgT6+rmQzMArubjI5D5BxO
 Lcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130189; x=1793734989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A+jCT1srzkiU114lsj7BnmbRqKFkNb+yMqW70UM/kqc=;
 b=zU2dcuxUV9EUqCjFnMNSw1WisewrWR3Edtxy7U+3z7gpmVzXnTwe5XpJDg2MUUnTzA
 m+altyG+jyO7aMhRg99+diH7eYfahRxt1+0gXc1u3yMM/zDQZ8xBOQ79TVd2dw4RnW5n
 jqiLuhI7Bqyl3z2+179xjHnS3ChqywWwNRaOpSajvNPK4ov1XzCBL2Aha/yEhcXAwkSC
 FPxM93ee+ILYyd+x0OUV6ZUB66djbUIBJC9tMz+IBlh6JStkMiyJGbGp1JBzZDs0sKDf
 mWaWkZ0KnwMMICR6BwAxbwEQTNnyX/44U0K7dYhU6JY5++ucHeD1RYHzN51lNg0pnKk5
 jRrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0l71qLE3goP/lNGAmxsDR78+ydsPO9Y3Si6dL9Juzxt79F4KIe5LUjJzukY4B8IDA/ZMZDh7u+y8P@nongnu.org
X-Gm-Message-State: AFq9FYJb0Ycel6plilQGKIq7rL/lzydYNAQLFUTdFb7xHRdUCXtrlbqF
 K0v2gPfwbDwkYQYB1bAum4mg1V1CyeEPpiAPO1Hrmlf4aJ0QgqrAm+uO
X-Gm-Gg: AYBFou1noBeWabysbPw42RScBAjKSJG8jaE0IsikQdmzUg+wb5XG3r3ojcaHHEtWvTK
 QaN59j+NZp1lfNHH5kQecuHDtfk9mDprn0RGzbyL4zTr6sys0xumR8gN/T1GmP3KZEVAxqzQGxl
 I/7VhKdJsUTCiGaL+grE/eaaPdcPSijuvPZfBIvuntRwSGboyq/7RLZtELyfrftP8t9WYkWdpft
 GRnrikGkugNP3al9uE/pzGeYv89HMq/ih8Lxx3pHbjULqVAYsPhV/+d05u33+mu79hxtp4SH93t
 KVW1nZX/MT4Of4oQSjAJ+wzVxBVQKlvTMKb8BAjynUgWsIPrb3N28unnsrsUq3bw6mBTXmJ25O5
 cjqoO/+5O21Px5AMj6eve0qg6jnaI1Q9yrfe6g2sd6OuoXctq1Z/wRZe85LaM+dQfT1ErjC+W3h
 vQ95pJW8uTC6Ti0UBKjaKeEoYYJGPggH+HvFRL1uoEB2doSM9xPD5VCGu1H0SivKuQIeFh5wK7p
 fmq7jdHQ155x+DK/EZoMfpt4cjbwq+HMKYAHaRiBYd7sW2ryv3IqLAtWG2z6k1UG5z3jcS1nx6e
 WEdZPY78eUyPLZorB/I0Wm52Tnlf1mm0Ioay8uzQcpFhpuevrt0WvacQOoaG53OBd/WyE3erIeE
 DsRp+lCt8JpOMFPisdeZKyeYb2NffzfgSctfewI4+573wI4KuTQ==
X-Received: by 2002:a05:7300:b196:b0:36a:30b:5dc0 with SMTP id
 5a478bee46e88-36a203bb12amr539789eec.24.1793130188467; 
 Tue, 27 Oct 2026 12:43:08 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a064510b0sm20446558eec.2.2026.10.27.12.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:43:07 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: sarkarsoumyajyoti23@gmail.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v2 1/8] ui/input: add high-resolution scroll input event
Date: Wed, 28 Oct 2026 01:12:49 +0530
Message-ID: <20261027194256.76031-2-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
References: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::b;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dy2-x0b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

The input layer can only describe wheel movement as WHEEL_UP/DOWN/
LEFT/RIGHT button clicks, one per detent. Host UIs that receive
smooth scroll deltas (touchpads, free-spinning or high-resolution
wheels) have to round them to whole clicks and the guest never sees
the finer movement.

Add a new 'scroll' input event kind carrying a scroll axis (vertical
or horizontal) and a distance in 1/120 of a wheel detent, the same
unit Windows uses for WHEEL_DELTA and Linux for REL_WHEEL_HI_RES.
Positive values scroll down or right.

Scroll events are routed to the handler that receives pointer button
events for the console. Handlers that do not set
INPUT_EVENT_MASK_SCROLL keep working unchanged: the input core
accumulates the distance and emits one wheel button click per full
detent.

Also wire the new event into input-send-event, tracing and
record/replay.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 include/ui/input.h    |  6 ++++
 qapi/ui.json          | 45 ++++++++++++++++++++++--
 replay/replay-input.c |  8 +++++
 ui/input.c            | 82 ++++++++++++++++++++++++++++++++++++++++++-
 ui/trace-events       |  1 +
 5 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index a1560cac0f..daedb547ff 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -9,6 +9,9 @@
 #define INPUT_EVENT_MASK_REL   (1<<INPUT_EVENT_KIND_REL)
 #define INPUT_EVENT_MASK_ABS   (1<<INPUT_EVENT_KIND_ABS)
 #define INPUT_EVENT_MASK_MTT   (1<<INPUT_EVENT_KIND_MTT)
+#define INPUT_EVENT_MASK_SCROLL (1 << INPUT_EVENT_KIND_SCROLL)
+
+#define INPUT_EVENT_SCROLL_DETENT 120
 
 #define INPUT_EVENT_ABS_MIN    0x0000
 #define INPUT_EVENT_ABS_MAX    0x7FFF
@@ -31,6 +34,7 @@ typedef struct QemuInputEvent {
         InputMoveEvent rel;
         InputMoveEvent abs;
         InputMultiTouchEvent mtt;
+        InputScrollEvent scroll;
     };
 } QemuInputEvent;
 
@@ -80,6 +84,8 @@ int qemu_input_scale_axis(int value,
 void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value);
 void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
                           int min_in, int max_in);
+void qemu_input_queue_scroll(QemuConsole *src, InputScrollAxis axis,
+                             int value);
 void qemu_input_queue_mtt(QemuConsole *src, InputMultiTouchType type, int slot,
                           int tracking_id);
 void qemu_input_queue_mtt_abs(QemuConsole *src, InputAxis axis, int value,
diff --git a/qapi/ui.json b/qapi/ui.json
index 9e3e80a3d7..e31fd74f87 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1120,6 +1120,34 @@
               'axis'       : 'InputAxis',
               'value'      : 'int' } }
 
+##
+# @InputScrollAxis:
+#     Scroll axis of a pointer input device.
+#
+# @vertical: vertical wheel
+#
+# @horizontal: horizontal wheel (pan)
+#
+# Since: 11.2
+##
+{ 'enum'  : 'InputScrollAxis',
+  'data'  : [ 'vertical', 'horizontal' ] }
+
+##
+# @InputScrollEvent:
+#     High-resolution scroll input event.
+#
+# @axis: Which scroll axis is referenced by @value.
+#
+# @value: Scroll distance in 1/120 of a wheel detent.  Positive
+#     values scroll down (vertical) or right (horizontal).
+#
+# Since: 11.2
+##
+{ 'struct'  : 'InputScrollEvent',
+  'data'  : { 'axis'    : 'InputScrollAxis',
+              'value'   : 'int' } }
+
 ##
 # @InputEventKind:
 #
@@ -1133,10 +1161,12 @@
 #
 # @mtt: a multi-touch input event
 #
+# @scroll: a high-resolution scroll input event (since 11.2)
+#
 # Since: 2.0
 ##
 { 'enum': 'InputEventKind',
-  'data': [ 'key', 'btn', 'rel', 'abs', 'mtt' ] }
+  'data': [ 'key', 'btn', 'rel', 'abs', 'mtt', 'scroll' ] }
 
 ##
 # @InputKeyEventWrapper:
@@ -1178,6 +1208,16 @@
 { 'struct': 'InputMultiTouchEventWrapper',
   'data': { 'data': 'InputMultiTouchEvent' } }
 
+##
+# @InputScrollEventWrapper:
+#
+# @data: High-resolution scroll input event
+#
+# Since: 11.2
+##
+{ 'struct': 'InputScrollEventWrapper',
+  'data': { 'data': 'InputScrollEvent' } }
+
 ##
 # @InputEvent:
 #     Input event union.
@@ -1193,7 +1233,8 @@
               'btn'     : 'InputBtnEventWrapper',
               'rel'     : 'InputMoveEventWrapper',
               'abs'     : 'InputMoveEventWrapper',
-              'mtt'     : 'InputMultiTouchEventWrapper' } }
+              'mtt'     : 'InputMultiTouchEventWrapper',
+              'scroll'  : 'InputScrollEventWrapper' } }
 
 ##
 # @input-send-event:
diff --git a/replay/replay-input.c b/replay/replay-input.c
index c86e00af0e..188c43a137 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -45,6 +45,10 @@ void replay_save_input_event(QemuInputEvent *evt)
         replay_put_dword(evt->mtt.axis);
         replay_put_qword(evt->mtt.value);
         break;
+    case INPUT_EVENT_KIND_SCROLL:
+        replay_put_dword(evt->scroll.axis);
+        replay_put_qword(evt->scroll.value);
+        break;
     case INPUT_EVENT_KIND__MAX:
         /* keep gcc happy */
         break;
@@ -80,6 +84,10 @@ QemuInputEvent *replay_read_input_event(void)
         evt->mtt.axis = (InputAxis)replay_get_dword();
         evt->mtt.value = replay_get_qword();
         break;
+    case INPUT_EVENT_KIND_SCROLL:
+        evt->scroll.axis = (InputScrollAxis)replay_get_dword();
+        evt->scroll.value = replay_get_qword();
+        break;
     case INPUT_EVENT_KIND__MAX:
         /* keep gcc happy */
         break;
diff --git a/ui/input.c b/ui/input.c
index f40a988370..f9ae49e275 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -181,7 +181,12 @@ void qmp_input_send_event(const char *device,
     for (e = events; e != NULL; e = e->next) {
         InputEvent *event = e->value;
 
-        if (!qemu_input_find_handler(1 << event->type, con)) {
+        uint32_t mask = 1 << event->type;
+
+        if (event->type == INPUT_EVENT_KIND_SCROLL) {
+            mask |= INPUT_EVENT_MASK_BTN;
+        }
+        if (!qemu_input_find_handler(mask, con)) {
             error_setg(errp, "Input handler not found for "
                              "event type %s",
                             InputEventKind_str(event->type));
@@ -217,6 +222,10 @@ void qmp_input_send_event(const char *device,
             evt.mtt = *qapi->u.mtt.data;
             break;
 
+        case INPUT_EVENT_KIND_SCROLL:
+            evt.scroll = *qapi->u.scroll.data;
+            break;
+
         default:
             g_assert_not_reached();
         }
@@ -235,6 +244,7 @@ static void qemu_input_event_trace(QemuConsole *src, QemuInputEvent *evt)
     InputBtnEvent *btn;
     InputMoveEvent *move;
     InputMultiTouchEvent *mtt;
+    InputScrollEvent *scroll;
 
     if (src) {
         idx = qemu_console_get_index(src);
@@ -265,6 +275,12 @@ static void qemu_input_event_trace(QemuConsole *src, QemuInputEvent *evt)
         name = mtt->axis < INPUT_AXIS__MAX ? InputAxis_str(mtt->axis) : "invalid";
         trace_input_event_mtt(idx, name, mtt->value);
         break;
+    case INPUT_EVENT_KIND_SCROLL:
+        scroll = &evt->scroll;
+        name = scroll->axis < INPUT_SCROLL_AXIS__MAX ?
+            InputScrollAxis_str(scroll->axis) : "invalid";
+        trace_input_event_scroll(idx, name, scroll->value);
+        break;
     case INPUT_EVENT_KIND__MAX:
         /* keep gcc happy */
         break;
@@ -342,12 +358,62 @@ static void qemu_input_queue_sync(QemuInputEventQueueHead *queue)
     queue_count++;
 }
 
+static void qemu_input_scroll_to_btn(QemuInputHandlerState *s,
+                                     QemuConsole *src, QemuInputEvent *evt)
+{
+    static int residual[INPUT_SCROLL_AXIS__MAX];
+    QemuInputEvent btn = { .type = INPUT_EVENT_KIND_BTN };
+    InputScrollAxis axis = evt->scroll.axis;
+
+    if (axis >= INPUT_SCROLL_AXIS__MAX) {
+        return;
+    }
+
+    residual[axis] += evt->scroll.value;
+    while (abs(residual[axis]) >= INPUT_EVENT_SCROLL_DETENT) {
+        bool fwd = residual[axis] > 0;
+
+        if (axis == INPUT_SCROLL_AXIS_VERTICAL) {
+            btn.btn.button = fwd ? INPUT_BUTTON_WHEEL_DOWN
+                                 : INPUT_BUTTON_WHEEL_UP;
+        } else {
+            btn.btn.button = fwd ? INPUT_BUTTON_WHEEL_RIGHT
+                                 : INPUT_BUTTON_WHEEL_LEFT;
+        }
+        residual[axis] -= fwd ? INPUT_EVENT_SCROLL_DETENT
+                              : -INPUT_EVENT_SCROLL_DETENT;
+
+        btn.btn.down = true;
+        qemu_input_event_trace(src, &btn);
+        s->handler->event(s->dev, src, &btn);
+        btn.btn.down = false;
+        qemu_input_event_trace(src, &btn);
+        s->handler->event(s->dev, src, &btn);
+        s->events++;
+    }
+}
+
 void qemu_input_event_send_impl(QemuConsole *src, QemuInputEvent *evt)
 {
     QemuInputHandlerState *s;
 
     qemu_input_event_trace(src, evt);
 
+    if (evt->type == INPUT_EVENT_KIND_SCROLL) {
+        s = qemu_input_find_handler(INPUT_EVENT_MASK_BTN |
+                                    INPUT_EVENT_MASK_SCROLL, src);
+        if (!s) {
+            return;
+        }
+        if (s->handler->mask & INPUT_EVENT_MASK_SCROLL) {
+            s->handler->event(s->dev, src, evt);
+            s->events++;
+        } else {
+            qemu_input_scroll_to_btn(s, src, evt);
+        }
+        return;
+    }
+
     /* send event */
     s = qemu_input_find_handler(1 << evt->type, src);
     if (!s) {
@@ -518,6 +584,20 @@ void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
     qemu_input_event_send(src, &evt);
 }
 
+void qemu_input_queue_scroll(QemuConsole *src, InputScrollAxis axis,
+                             int value)
+{
+    QemuInputEvent evt = {
+        .type = INPUT_EVENT_KIND_SCROLL,
+        .scroll = {
+            .axis = axis,
+            .value = value,
+        },
+    };
+
+    qemu_input_event_send(src, &evt);
+}
+
 void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
                           int min_in, int max_in)
 {
diff --git a/ui/trace-events b/ui/trace-events
index 339a61f341..638096607a 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -132,6 +132,7 @@ input_event_btn(int conidx, const char *btn, bool down) "con %d, button %s, down
 input_event_rel(int conidx, const char *axis, int value) "con %d, axis %s, value %d"
 input_event_abs(int conidx, const char *axis, int value) "con %d, axis %s, value 0x%x"
 input_event_mtt(int conidx, const char *axis, int value) "con %d, axis %s, value 0x%x"
+input_event_scroll(int conidx, const char *axis, int value) "con %d, axis %s, value %d"
 input_event_sync(void) ""
 
 # sdl2-input.c
-- 
2.56.0


