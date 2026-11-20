Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B422606A6D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tKKp6jJe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUsY-0001RV-VW; Fri, 20 Nov 2026 15:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrO-00018v-BX
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:27 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrJ-0001sf-Tg
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:26 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so724373f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205119; x=1795809919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8sj3XM3juFxRlzwk37qD2+Hj895MXW4UVML2Y9WgI8c=;
 b=tKKp6jJetxyxS3fZw/z+a2HiLc3sGjLoxym3mnRa4EZi5Zce9tDpkwj825wsR1jr5S
 Yoa9CkjFrgzxt1FxByhmuLmyY+2ox+t+65TdKYHxaFGOnAJWYvnZQNdeb5WqvN26FMN7
 dU5kMhfJmF14pjQvnunOxnsnDuhj9mr2pyuLBf3N2z61d6sKy4H8TiLbZ2ve03JvXRgc
 1thiLSf67y2u1qjKFa4O8spoDV5CPOWBMkfgLUBhIqxCIdSBlLo0AwblQlwESvOIyZMT
 EajZwMhwkeS8X+GQuwPvY5okF8IidmT0r5s7fp2wta+Jp8xDpM33USsA0ycZsVirZBJB
 TPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205119; x=1795809919;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8sj3XM3juFxRlzwk37qD2+Hj895MXW4UVML2Y9WgI8c=;
 b=WegFzWsoSCdoFPjBc3p43IlhzLOtagzZWaaNkA4aldl9YNCpR1g8OZGzENRaUkNBfx
 8g6rjuE0mVGc8EmuNdNbn+xvWuwLBG8gNXTyilv8fXhNboQr6w/OLtjxc6f7vMEJ8awU
 473fKsinWjZgBobX+dP7yWsL/rSae6fFX6zmXtHheJKer1dOfvae7Xcf6xhrgCbKo8b/
 Rtp9OpDEAesrdH6MYILGgmxlMyDknGAUTzgE/IYo9dwB1sJfon+hwnCxCsETzvzA3585
 /sQauCQuiWBS5B1S6EI+qlm/gKwFOLSeQS/Dr9I+TtTULJoQt5AySog7gvPAtLVnn6Or
 BNqQ==
X-Gm-Message-State: APuU4Z+t/QsHcI/yVLImleDSWreTQl6xBRX4ADFMpqBYlqviOpcIxD2J
 HnPJgFY37DCUndoeXRrMXcthAreIocto/rx77FcocGhw+/LXZ6M2Hb7PzTxS6b3I2yo=
X-Gm-Gg: AZFdTZfbvr98o+9E83AjvGbM+qQqLwqUyQy2ZvDtSz7+1RRbQkHJOhrspm8EDtmmrR2
 5A381hQ60eA/bhxCRSW5tXLXICjqROglDP6BsMbHVjLe1ouTpPF2zGQ5p6w8TdODXJooP4ILr1A
 VoLarNnCeOY9QVIwPOTq8yX2LtgvHc5feJ4vokem8tNDCkrKUiHMb3Bq8QgjJhwv05YxFqidEhF
 nwowSo7Sw2vNX+IL6pew+JoxMwwrAPBOm4b/vZN122uDvCPKDS4XTti5mu8LWZHjvdVhttliU6X
 0eHqnQyUckhz4kwkrXzhcd9dogbU1SyfJU6nJPf3eafRwHhhzJoc1ZwLZe3Vt4WJG7u5tMBkQoY
 phgytvkZeJYFRq5h/iWnH7M5Anipqpz5EFImGUOGFn8/zFi9ErFl+xydxwPXcXneU/V8SCrJgPD
 tAhaIoy9zq3viGIyUWShjGYG0SjDF4HywcUKP4513JtNsD91OZGrLPO8lTp+ICTHd9HpW6tRkgq
 dvl1rGjcWyScPKMziIcd9J7xT1yN7AYRwm7W4utN8H26sojc+AGUu1/M30zA4aImmGtRfJtq8t/
 urWkn8FXTRb7bNibIHv/oECWfr6g
X-Received: by 2002:a05:6000:4705:b0:48d:f851:ee5f with SMTP id
 ffacd0b85a97d-4abb225e5f9mr9218847f8f.24.1795205119460; 
 Fri, 20 Nov 2026 12:05:19 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bc8ce06sm7379746f8f.47.2026.11.20.12.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CAD4D5FBA6;
 Fri, 20 Nov 2026 20:05:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 14/22] scripts/get_maintainer.py: add --list-maintainers
Date: Fri, 20 Nov 2026 20:05:02 +0000
Message-ID: <20261120200511.822573-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

This option will dump a list of maintainers in a CSV format together
with some useful information including:

  - Name
  - gitlab handle
  - the date they first became a maintainer
  - the date they first become a reviewer
  - the date of their first contribution (commit or on list)
  - the date of the last contribution
  - how many sub-systems they maintain

The idea being we can feed this information into a graphing tool to
get an idea of the demographics of our maintainers.

The last contribution date will hopefully replace custom scripts when
we are cleaning up the MAINTAINERS file for those no longer active in
development.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 155 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 154f2650f72..f164e2c5c55 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -22,7 +22,7 @@
 from re import IGNORECASE
 from regex import compile as prec_compile
 from git import Repo
-from collections import Counter
+from collections import Counter, defaultdict
 from csv import writer as csv_writer
 
 #
@@ -429,6 +429,149 @@ def find_src_root():
 
     return None
 
+#
+# Helpers for maintainer statistics
+#
+# We assume the current state of MAINTAINERS as parsed from the
+# working tree is the authoritative source for who is currently a
+# maintainer, as well as their canonical name spelling and primary
+# email address. Historical commits or older MAINTAINERS revisions
+# with alternate name transliterations or older email addresses are
+# mapped back onto these current canonical maintainer names.
+#
+
+
+def get_maintainer_since(repo, maintainers, email_to_maint):
+    """
+    Scan git history of MAINTAINERS to determine the earliest date
+    each maintainer was added as a maintainer (M:) or reviewer (R:).
+    Returns (maintainer_since, reviewer_since) dictionaries.
+    """
+    maintainer_since = {}
+    reviewer_since = {}
+    current_date = None
+
+    tag_re = re_compile(r'^\+\s*([MR]):\s*([^<]+?)\s*<([^>]+)>')
+
+    log_output = repo.git.log('-p', '--format=COMMIT %as', '--', 'MAINTAINERS')
+    for line in log_output.splitlines():
+        if line.startswith('COMMIT '):
+            current_date = line[7:17]
+        elif line.startswith('+') and not line.startswith('+++'):
+            m = tag_re.match(line)
+            if m:
+                tag, name, email = m.group(1), m.group(2), m.group(3)
+                target = (name if name in maintainers
+                          else email_to_maint.get(email))
+                if target:
+                    since_dict = (maintainer_since if tag == 'M'
+                                  else reviewer_since)
+                    if (target not in since_dict or
+                            current_date < since_dict[target]):
+                        since_dict[target] = current_date
+    return maintainer_since, reviewer_since
+
+
+def get_contributor_dates(repo, maintainers, email_to_maint):
+    """
+    Scan git history for author and committer dates, as well as review/ack
+    trailers, to determine the first and last contribution dates for
+    maintainers.
+
+    Trailers are dated by the author date, as are MAINTAINERS entries in
+    get_maintainer_since(), so a patch adding its own maintainer lines
+    doesn't appear to predate the maintainer's involvement.
+
+    Returns (first_contrib, last_contrib) dictionaries mapping maintainer
+    canonical names to ISO date strings.
+    """
+    trailer_keys = [
+        'Signed-off-by',
+        'Co-developed-by',
+        'Reviewed-by',
+        'Tested-by',
+        'Acked-by',
+    ]
+    trailer_args = ','.join(f'key={k}' for k in trailer_keys)
+    log_format = (
+        '%as|%aN|%aE|%cs|%cN|%cE|'
+        f'%(trailers:{trailer_args},valueonly,unfold,separator=|)'
+    )
+
+    first_contrib = {}
+    last_contrib = {}
+
+    def record_date(name, email, date):
+        target = name if name in maintainers else email_to_maint.get(email)
+        if target:
+            first_contrib[target] = min(first_contrib.get(target, date), date)
+            last_contrib[target] = max(last_contrib.get(target, date), date)
+
+    for line in repo.git.log(f'--format={log_format}').splitlines():
+        if not line:
+            continue
+        parts = line.split('|')
+        a_date, a_name, a_email, c_date, c_name, c_email = parts[:6]
+
+        record_date(a_name, a_email, a_date)
+        record_date(c_name, c_email, c_date)
+
+        for trailer in parts[6:]:
+            m = person_re.match(trailer.strip())
+            if m:
+                record_date(m.group('name'), m.group('email'), a_date)
+
+    return first_contrib, last_contrib
+
+
+def dump_maintainers_csv(src, maint_sections):
+    """
+    Dump a CSV summary of maintainer statistics to stdout.
+    """
+    maintainers = defaultdict(lambda: {'subsystems': 0, 'emails': set()})
+    for s in maint_sections:
+        if s.status not in (Status.ORPHAN, Status.OBSOLETE):
+            for m in s.maintainers:
+                maintainers[m.name]['subsystems'] += 1
+                maintainers[m.name]['emails'].add(m.email)
+
+    email_to_maint = {}
+    for name, data in maintainers.items():
+        for email in data['emails']:
+            email_to_maint[email] = name
+
+    name_to_handle = load_gitlab_handles(src)
+    repo = Repo(src)
+
+    maintainer_since, reviewer_since = get_maintainer_since(
+        repo, maintainers, email_to_maint
+    )
+    first_contrib, last_contrib = get_contributor_dates(
+        repo, maintainers, email_to_maint
+    )
+
+    writer = csv_writer(sys.stdout)
+    headers = [
+        "Maintainer Name",
+        "gitlab handle",
+        "Subsystems Maintained",
+        "Maintainer Since",
+        "Reviewer Since",
+        "Contributor Since",
+        "Date of last contribution",
+    ]
+    writer.writerow(headers)
+    for name in sorted(maintainers.keys()):
+        writer.writerow([
+            name,
+            name_to_handle.get(name, ""),
+            maintainers[name]["subsystems"],
+            maintainer_since.get(name, ""),
+            reviewer_since.get(name, ""),
+            first_contrib.get(name, ""),
+            last_contrib.get(name, ""),
+        ])
+
 #
 # Argument validation
 #
@@ -480,6 +623,12 @@ def parse_args():
     parser.add_argument('--list-reviewed-by', metavar='REGEX',
                         help='List sections where reviewer matches REGEX')
 
+    # List maintainers
+    parser.add_argument('--list-maintainers',
+                        action=BooleanOptionalAction,
+                        default=False,
+                        help="Dump maintainers summary as CSV")
+
     # We need to know or be told where the root of the source tree is
     src = find_src_root()
 
@@ -556,6 +705,10 @@ def main():
                              len(ms.files), len(ms.keywords), len(ms.trees)])
         sys.exit(0)
 
+    if args.list_maintainers:
+        dump_maintainers_csv(args.src, maint_sections)
+        sys.exit(0)
+
     # Build array of Path objects representing the files
     if args.list_maintained_by or args.list_reviewed_by:
         if args.list_maintained_by:
-- 
2.47.3


