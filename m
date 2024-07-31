Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B2FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 00:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYxRa-0001FI-Vq; Tue, 30 Jul 2024 20:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junon@oro.sh>) id 1sYxRZ-0001Eh-IM
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 20:43:53 -0400
Received: from out-170.mta1.migadu.com ([95.215.58.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junon@oro.sh>) id 1sYxRU-0006Lr-Sr
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 20:43:53 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oro.sh; s=key1;
 t=1722386625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKStcvp3+8BcVc2X8J7gz4oJZRZad3Aefu3O5o/xU1Y=;
 b=lbP1QsFaMTUxPjqo3YrLLEJ8kK0Oa7R0d/Ts/D75T3jJ7G6ajfCfvEqFCJ9wcBdn+zEisr
 blFstOlXxlfQATRk86SzkUJDUQ2X+uER48JfVOqiwo3PPg+6NDNcH6jWy1z5gNfOe2f5rU
 q1dXps4Dm2EcFoYCpUrDhO1frJ5ZD04=
Date: Wed, 31 Jul 2024 00:43:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: junon@oro.sh
Message-ID: <a2842ec779c036b09dc429f883e28ccc073d0c22@oro.sh>
TLS-Required: No
Subject: Re: [PATCH] qmp: Add 'memtranslate' QMP command
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, "Richard Henderson"
 <richard.henderson@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>,
 "Markus Armbruster" <armbru@redhat.com>, "Eric Blake"
 <eblake@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>,
 "Peter Xu" <peterx@redhat.com>, "David Hildenbrand" <david@redhat.com>,
 "Thomas Huth" <thuth@redhat.com>, "Laurent Vivier" <lvivier@redhat.com>
In-Reply-To: <ZqmBXTVV52qkk9Ed@gallifrey>
References: <20240730213432.18074-1-junon@oro.sh> <ZqmBXTVV52qkk9Ed@gallifrey>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.170; envelope-from=junon@oro.sh;
 helo=out-170.mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

31 July 2024 at 02:12, "Dr. David Alan Gilbert" <dave@treblig.org> wrote:

Hello Dr. Gilbert,

>=20
>=20* Josh Junon (junon@oro.sh) wrote:
>=20
>=20Hi Josh,
>=20
>=20>=20
>=20> This commit adds a new QMP/HMP command `memtranslate`,
> >=20
>=20>  which translates a virtual address to a physical address
> >=20
>=20>  using the guest's MMU.
> >=20
>=20>=20=20
>=20>=20
>=20>  This uses the same mechanism that `[p]memsave` does to
> >=20
>=20>  perform the translation.
> >=20
>=20>=20=20
>=20>=20
>=20>  This commit also fixes a long standing issue of `[p]memsave`
> >=20
>=20>  not properly handling higher-half virtual addresses correctly,
> >=20
>=20>  namely when used over QMP/the monitor. The use and assumption of
> >=20
>=20>  signed integers caused issues when parsing otherwise valid
> >=20
>=20>  virtual addresses that instead caused signed integer overflow
> >=20
>=20>  or ERANGE errors.
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Josh Junon <junon@oro.sh>
> >=20
>=20
> There's a few different changes in this one patch; so the first
>=20
>=20thing is it needs splitting up; I suggest at least:
>=20
>=20 a) Fixing the signedness problems
>=20
>=20 b) The QMP implementation of the new command
>=20
>=20 c) The HMP implementation of the new command
>=20
>=20That would make it a lot easier to review - also, it's good
>=20
>=20to get fixes in first!
>=20
>=20Now, going back a step; how does this compare to the existing
>=20
>=20'gva2gpa' command which HMP has?
>=20

Good=20catch, they're definitely the same. I didn't see that was there be=
fore, perhaps because of the name. I've been looking for this exact comma=
nd for a while now, so it surprises me that I missed it!

Since that's an HMP-only command, would it be okay if simply redirected i=
ts definition to a new qmp_gva2gpa command so the implementation is all i=
n one spot?

If that's amenable, I can patch in the signedness fixes, then submit qmp_=
gva2gpa, then changing hmp_gva2gpa to use the qmp_gva2gpa similar to how =
other HMP commands with QMP analogs are implemented. Just let me know if =
that works and I'll get on it.


I appreciate the response!


Josh

>=20
>=20>=20
>=20> ---
> >=20
>=20>  docs/devel/loads-stores.rst | 11 ++
> >=20
>=20>  hmp-commands.hx | 16 ++-
> >=20
>=20>  hw/core/machine-hmp-cmds.c | 34 ++++-
> >=20
>=20>  include/exec/cpu-common.h | 5 +
> >=20
>=20>  include/monitor/hmp.h | 1 +
> >=20
>=20>  include/qapi/qmp/qdict.h | 4 +
> >=20
>=20>  monitor/hmp-expr.inc | 200 ++++++++++++++++++++++++++++++
> >=20
>=20>  monitor/hmp.c | 241 ++++++++----------------------------
> >=20
>=20>  qapi/machine.json | 42 ++++++-
> >=20
>=20>  qobject/qdict.c | 38 ++++++
> >=20
>=20>  system/cpus.c | 31 ++++-
> >=20
>=20>  system/physmem.c | 18 +++
> >=20
>=20>  tests/qtest/test-hmp.c | 1 +
> >=20
>=20>  tests/unit/check-qdict.c | 39 ++++++
> >=20
>=20>  14 files changed, 482 insertions(+), 199 deletions(-)
> >=20
>=20>  create mode 100644 monitor/hmp-expr.inc
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores=
.rst
> >=20
>=20>  index ec627aa9c0..c2bf4bd015 100644
> >=20
>=20>  --- a/docs/devel/loads-stores.rst
> >=20
>=20>  +++ b/docs/devel/loads-stores.rst
> >=20
>=20>  @@ -465,6 +465,17 @@ For new code they are better avoided:
> >=20
>=20>  Regexes for git grep:
> >=20
>=20>  - ``\<cpu_physical_memory_\(read\|write\|rw\)\>``
> >=20
>=20>=20=20
>=20>=20
>=20>  +``cpu_memory_translate``
> >=20
>=20>  +~~~~~~~~~~~~~~~~~~~~~~~~
> >=20
>=20>  +
> >=20
>=20>  +Translates a virtual address to a physical address.
> >=20
>=20>  +
> >=20
>=20>  +This function is intended for use by QMP/HMP and similar code.
> >=20
>=20>  +It takes a virtual address and returns the physical address
> >=20
>=20>  +as it's seen by the MMU via a lookup, along with other attributes
> >=20
>=20>  +of the page as well as what occurred during the lookup itself.
> >=20
>=20>  +
> >=20
>=20>  +
> >=20
>=20>  ``cpu_memory_rw_debug``
> >=20
>=20>  ~~~~~~~~~~~~~~~~~~~~~~~
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/hmp-commands.hx b/hmp-commands.hx
> >=20
>=20>  index 06746f0afc..213279e340 100644
> >=20
>=20>  --- a/hmp-commands.hx
> >=20
>=20>  +++ b/hmp-commands.hx
> >=20
>=20>  @@ -796,12 +796,24 @@ SRST
> >=20
>=20>  Stop capture with a given *index*, index can be obtained with::
> >=20
>=20>=20=20
>=20>=20
>=20>  info capture
> >=20
>=20>  +ERST
> >=20
>=20>  +
> >=20
>=20>  + {
> >=20
>=20>  + .name =3D "memtranslate",
> >=20
>=20>  + .args_type =3D "val:u",
> >=20
>=20>  + .params =3D "addr",
> >=20
>=20>  + .help =3D "translate a guest virtual address 'addr' to a physica=
l address",
> >=20
>=20>  + .cmd =3D hmp_memtranslate,
> >=20
>=20>  + },
> >=20
>=20>=20=20
>=20>=20
>=20>  +SRST
> >=20
>=20>  +``memtranslate`` *addr*
> >=20
>=20>  + translate a guest virtual address *val* to a physical address
> >=20
>=20>  ERST
> >=20
>=20>=20=20
>=20>=20
>=20>  {
> >=20
>=20>  .name =3D "memsave",
> >=20
>=20>  - .args_type =3D "val:l,size:i,filename:s",
> >=20
>=20>  + .args_type =3D "val:u,size:u,filename:s",
> >=20
>=20>  .params =3D "addr size file",
> >=20
>=20>  .help =3D "save to disk virtual memory dump starting at 'addr' of =
size 'size'",
> >=20
>=20>  .cmd =3D hmp_memsave,
> >=20
>=20>  @@ -814,7 +826,7 @@ ERST
> >=20
>=20>=20=20
>=20>=20
>=20>  {
> >=20
>=20>  .name =3D "pmemsave",
> >=20
>=20>  - .args_type =3D "val:l,size:i,filename:s",
> >=20
>=20>  + .args_type =3D "val:u,size:u,filename:s",
> >=20
>=20>  .params =3D "addr size file",
> >=20
>=20>  .help =3D "save to disk physical memory dump starting at 'addr' of=
 size 'size'",
> >=20
>=20>  .cmd =3D hmp_pmemsave,
> >=20
>=20>  diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds=
.c
> >=20
>=20>  index 8701f00cc7..cf4adfa80a 100644
> >=20
>=20>  --- a/hw/core/machine-hmp-cmds.c
> >=20
>=20>  +++ b/hw/core/machine-hmp-cmds.c
> >=20
>=20>  @@ -194,11 +194,37 @@ void hmp_system_powerdown(Monitor *mon, cons=
t QDict *qdict)
> >=20
>=20>  qmp_system_powerdown(NULL);
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  +void hmp_memtranslate(Monitor *mon, const QDict *qdict)
> >=20
>=20>  +{
> >=20
>=20>  + uint64_t addr =3D qdict_get_uint(qdict, "val");
> >=20
>=20>  + Error *err =3D NULL;
> >=20
>=20>  + int cpu_index =3D monitor_get_cpu_index(mon);
> >=20
>=20>  + MemTranslation *translation;
> >=20
>=20>  +
> >=20
>=20>  + if (cpu_index < 0) {
> >=20
>=20>  + monitor_printf(mon, "No CPU available\n");
> >=20
>=20>  + return;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + translation =3D qmp_memtranslate(addr, true, cpu_index, &err);
> >=20
>=20>  +
> >=20
>=20>  + if (err =3D=3D NULL) {
> >=20
>=20>  + if (translation->phys =3D=3D -1) {
> >=20
>=20>  + monitor_printf(mon, "failed to translate\n");
> >=20
>=20>  + } else {
> >=20
>=20>  + monitor_printf(mon, "phys: 0x%" PRIx64 "\n", translation->phys);
> >=20
>=20>  + }
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + qapi_free_MemTranslation(translation);
> >=20
>=20>  + hmp_handle_error(mon, err);
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  void hmp_memsave(Monitor *mon, const QDict *qdict)
> >=20
>=20>  {
> >=20
>=20>  - uint32_t size =3D qdict_get_int(qdict, "size");
> >=20
>=20>  + uint64_t size =3D qdict_get_uint(qdict, "size");
> >=20
>=20>  const char *filename =3D qdict_get_str(qdict, "filename");
> >=20
>=20>  - uint64_t addr =3D qdict_get_int(qdict, "val");
> >=20
>=20>  + uint64_t addr =3D qdict_get_uint(qdict, "val");
> >=20
>=20>  Error *err =3D NULL;
> >=20
>=20>  int cpu_index =3D monitor_get_cpu_index(mon);
> >=20
>=20>=20=20
>=20>=20
>=20>  @@ -213,9 +239,9 @@ void hmp_memsave(Monitor *mon, const QDict *qd=
ict)
> >=20
>=20>=20=20
>=20>=20
>=20>  void hmp_pmemsave(Monitor *mon, const QDict *qdict)
> >=20
>=20>  {
> >=20
>=20>  - uint32_t size =3D qdict_get_int(qdict, "size");
> >=20
>=20>  + uint64_t size =3D qdict_get_uint(qdict, "size");
> >=20
>=20>  const char *filename =3D qdict_get_str(qdict, "filename");
> >=20
>=20>  - uint64_t addr =3D qdict_get_int(qdict, "val");
> >=20
>=20>  + uint64_t addr =3D qdict_get_uint(qdict, "val");
> >=20
>=20>  Error *err =3D NULL;
> >=20
>=20>=20=20
>=20>=20
>=20>  qmp_pmemsave(addr, size, filename, &err);
> >=20
>=20>  diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> >=20
>=20>  index 2e1b499cb7..9484c82fe0 100644
> >=20
>=20>  --- a/include/exec/cpu-common.h
> >=20
>=20>  +++ b/include/exec/cpu-common.h
> >=20
>=20>  @@ -178,6 +178,11 @@ int ram_block_discard_guest_memfd_range(RAMBl=
ock *rb, uint64_t start,
> >=20
>=20>=20=20
>=20>=20
>=20>  #endif
> >=20
>=20>=20=20
>=20>=20
>=20>  +/* Returns: translated physical address on success, -1 on error.
> >=20
>=20>  + *=20If the address is not valid, `*attrs` is left untouched.
> >=20
>=20>  + */
> >=20
>=20>  +hwaddr cpu_memory_translate(CPUState *cpu, vaddr addr, MemTxAttrs=
 *attrs);
> >=20
>=20>  +
> >=20
>=20>  /* Returns: 0 on success, -1 on error */
> >=20
>=20>  int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
> >=20
>=20>  void *ptr, size_t len, bool is_write);
> >=20
>=20>  diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> >=20
>=20>  index ae116d9804..febccf13cc 100644
> >=20
>=20>  --- a/include/monitor/hmp.h
> >=20
>=20>  +++ b/include/monitor/hmp.h
> >=20
>=20>  @@ -47,6 +47,7 @@ void hmp_system_powerdown(Monitor *mon, const QD=
ict *qdict);
> >=20
>=20>  void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
> >=20
>=20>  void hmp_announce_self(Monitor *mon, const QDict *qdict);
> >=20
>=20>  void hmp_cpu(Monitor *mon, const QDict *qdict);
> >=20
>=20>  +void hmp_memtranslate(Monitor *mon, const QDict *qdict);
> >=20
>=20>  void hmp_memsave(Monitor *mon, const QDict *qdict);
> >=20
>=20>  void hmp_pmemsave(Monitor *mon, const QDict *qdict);
> >=20
>=20>  void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
> >=20
>=20>  diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> >=20
>=20>  index 82e90fc072..38c310becb 100644
> >=20
>=20>  --- a/include/qapi/qmp/qdict.h
> >=20
>=20>  +++ b/include/qapi/qmp/qdict.h
> >=20
>=20>  @@ -52,17 +52,21 @@ const QDictEntry *qdict_next(const QDict *qdic=
t, const QDictEntry *entry);
> >=20
>=20>=20=20
>=20>=20
>=20>  void qdict_put_bool(QDict *qdict, const char *key, bool value);
> >=20
>=20>  void qdict_put_int(QDict *qdict, const char *key, int64_t value);
> >=20
>=20>  +void qdict_put_uint(QDict *qdict, const char *key, uint64_t value=
);
> >=20
>=20>  void qdict_put_null(QDict *qdict, const char *key);
> >=20
>=20>  void qdict_put_str(QDict *qdict, const char *key, const char *valu=
e);
> >=20
>=20>=20=20
>=20>=20
>=20>  double qdict_get_double(const QDict *qdict, const char *key);
> >=20
>=20>  int64_t qdict_get_int(const QDict *qdict, const char *key);
> >=20
>=20>  +uint64_t qdict_get_uint(const QDict *qdict, const char *key);
> >=20
>=20>  bool qdict_get_bool(const QDict *qdict, const char *key);
> >=20
>=20>  QList *qdict_get_qlist(const QDict *qdict, const char *key);
> >=20
>=20>  QDict *qdict_get_qdict(const QDict *qdict, const char *key);
> >=20
>=20>  const char *qdict_get_str(const QDict *qdict, const char *key);
> >=20
>=20>  int64_t qdict_get_try_int(const QDict *qdict, const char *key,
> >=20
>=20>  int64_t def_value);
> >=20
>=20>  +uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
> >=20
>=20>  + uint64_t def_value);
> >=20
>=20>  bool qdict_get_try_bool(const QDict *qdict, const char *key, bool =
def_value);
> >=20
>=20>  const char *qdict_get_try_str(const QDict *qdict, const char *key)=
;
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/monitor/hmp-expr.inc b/monitor/hmp-expr.inc
> >=20
>=20>  new file mode 100644
> >=20
>=20>  index 0000000000..789a957ed2
> >=20
>=20>  --- /dev/null
> >=20
>=20>  +++ b/monitor/hmp-expr.inc
> >=20
>=20>  @@ -0,0 +1,200 @@
> >=20
>=20>  +#ifndef HMP_EXPR_INC_TY
> >=20
>=20>  +#error "missing HMP_EXPR_INC_TY"
> >=20
>=20>  +#endif
> >=20
>=20>  +
> >=20
>=20>  +#ifndef HMP_EXPR_INC_IDENT
> >=20
>=20>  +#error "missing HMP_EXPR_INC_IDENT"
> >=20
>=20>  +#endif
> >=20
>=20>  +
> >=20
>=20>  +static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_sum)(Monitor *mon)=
;
> >=20
>=20>  +
> >=20
>=20>  +static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_unary)(Monitor *mo=
n)
> >=20
>=20>  +{
> >=20
>=20>  + HMP_EXPR_INC_TY n;
> >=20
>=20>  + char *p;
> >=20
>=20>  + int ret;
> >=20
>=20>  +
> >=20
>=20>  + switch (*pch) {
> >=20
>=20>  + case '+':
> >=20
>=20>  + next();
> >=20
>=20>  + n =3D HMP_EXPR_INC_IDENT(expr_unary)(mon);
> >=20
>=20>  + break;
> >=20
>=20>  + case '-':
> >=20
>=20>  + next();
> >=20
>=20>  + n =3D -HMP_EXPR_INC_IDENT(expr_unary)(mon);
> >=20
>=20>  + break;
> >=20
>=20>  + case '~':
> >=20
>=20>  + next();
> >=20
>=20>  + n =3D ~HMP_EXPR_INC_IDENT(expr_unary)(mon);
> >=20
>=20>  + break;
> >=20
>=20>  + case '(':
> >=20
>=20>  + next();
> >=20
>=20>  + n =3D HMP_EXPR_INC_IDENT(expr_sum)(mon);
> >=20
>=20>  + if (*pch !=3D ')') {
> >=20
>=20>  + expr_error(mon, "')' expected");
> >=20
>=20>  + }
> >=20
>=20>  + next();
> >=20
>=20>  + break;
> >=20
>=20>  + case '\'':
> >=20
>=20>  + pch++;
> >=20
>=20>  + if (*pch =3D=3D '\0') {
> >=20
>=20>  + expr_error(mon, "character constant expected");
> >=20
>=20>  + }
> >=20
>=20>  + n =3D *pch;
> >=20
>=20>  + pch++;
> >=20
>=20>  + if (*pch !=3D '\'') {
> >=20
>=20>  + expr_error(mon, "missing terminating \' character");
> >=20
>=20>  + }
> >=20
>=20>  + next();
> >=20
>=20>  + break;
> >=20
>=20>  + case '$':
> >=20
>=20>  + {
> >=20
>=20>  + char buf[128], *q;
> >=20
>=20>  + int64_t reg =3D 0;
> >=20
>=20>  +
> >=20
>=20>  + pch++;
> >=20
>=20>  + q =3D buf;
> >=20
>=20>  + while ((*pch >=3D 'a' && *pch <=3D 'z') ||
> >=20
>=20>  + (*pch >=3D 'A' && *pch <=3D 'Z') ||
> >=20
>=20>  + (*pch >=3D '0' && *pch <=3D '9') ||
> >=20
>=20>  + *pch =3D=3D '_' || *pch =3D=3D '.') {
> >=20
>=20>  + if ((q - buf) < sizeof(buf) - 1) {
> >=20
>=20>  + *q++ =3D *pch;
> >=20
>=20>  + }
> >=20
>=20>  + pch++;
> >=20
>=20>  + }
> >=20
>=20>  + while (qemu_isspace(*pch)) {
> >=20
>=20>  + pch++;
> >=20
>=20>  + }
> >=20
>=20>  + *q =3D 0;
> >=20
>=20>  + ret =3D get_monitor_def(mon, &reg, buf);
> >=20
>=20>  + if (ret < 0) {
> >=20
>=20>  + expr_error(mon, "unknown register");
> >=20
>=20>  + }
> >=20
>=20>  + n =3D (HMP_EXPR_INC_TY)reg;
> >=20
>=20>  + }
> >=20
>=20>  + break;
> >=20
>=20>  + case '\0':
> >=20
>=20>  + expr_error(mon, "unexpected end of expression");
> >=20
>=20>  + n =3D 0;
> >=20
>=20>  + break;
> >=20
>=20>  + default:
> >=20
>=20>  + errno =3D 0;
> >=20
>=20>  + n =3D strtoull(pch, &p, 0);
> >=20
>=20>  + if (errno =3D=3D ERANGE) {
> >=20
>=20>  + expr_error(mon, "number too large");
> >=20
>=20>  + }
> >=20
>=20>  + if (pch =3D=3D p) {
> >=20
>=20>  + expr_error(mon, "invalid char '%c' in expression", *p);
> >=20
>=20>  + }
> >=20
>=20>  + pch =3D p;
> >=20
>=20>  + while (qemu_isspace(*pch)) {
> >=20
>=20>  + pch++;
> >=20
>=20>  + }
> >=20
>=20>  + break;
> >=20
>=20>  + }
> >=20
>=20>  + return n;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_prod)(Monitor *mon=
)
> >=20
>=20>  +{
> >=20
>=20>  + HMP_EXPR_INC_TY val, val2;
> >=20
>=20>  + int op;
> >=20
>=20>  +
> >=20
>=20>  + val =3D HMP_EXPR_INC_IDENT(expr_unary)(mon);
> >=20
>=20>  + for (;;) {
> >=20
>=20>  + op =3D *pch;
> >=20
>=20>  + if (op !=3D '*' && op !=3D '/' && op !=3D '%') {
> >=20
>=20>  + break;
> >=20
>=20>  + }
> >=20
>=20>  + next();
> >=20
>=20>  + val2 =3D HMP_EXPR_INC_IDENT(expr_unary)(mon);
> >=20
>=20>  + switch (op) {
> >=20
>=20>  + default:
> >=20
>=20>  + case '*':
> >=20
>=20>  + val *=3D val2;
> >=20
>=20>  + break;
> >=20
>=20>  + case '/':
> >=20
>=20>  + case '%':
> >=20
>=20>  + if (val2 =3D=3D 0) {
> >=20
>=20>  + expr_error(mon, "division by zero");
> >=20
>=20>  + }
> >=20
>=20>  + if (op =3D=3D '/') {
> >=20
>=20>  + val /=3D val2;
> >=20
>=20>  + } else {
> >=20
>=20>  + val %=3D val2;
> >=20
>=20>  + }
> >=20
>=20>  + break;
> >=20
>=20>  + }
> >=20
>=20>  + }
> >=20
>=20>  + return val;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_logic)(Monitor *mo=
n)
> >=20
>=20>  +{
> >=20
>=20>  + HMP_EXPR_INC_TY val, val2;
> >=20
>=20>  + int op;
> >=20
>=20>  +
> >=20
>=20>  + val =3D HMP_EXPR_INC_IDENT(expr_prod)(mon);
> >=20
>=20>  + for (;;) {
> >=20
>=20>  + op =3D *pch;
> >=20
>=20>  + if (op !=3D '&' && op !=3D '|' && op !=3D '^') {
> >=20
>=20>  + break;
> >=20
>=20>  + }
> >=20
>=20>  + next();
> >=20
>=20>  + val2 =3D HMP_EXPR_INC_IDENT(expr_prod)(mon);
> >=20
>=20>  + switch (op) {
> >=20
>=20>  + default:
> >=20
>=20>  + case '&':
> >=20
>=20>  + val &=3D val2;
> >=20
>=20>  + break;
> >=20
>=20>  + case '|':
> >=20
>=20>  + val |=3D val2;
> >=20
>=20>  + break;
> >=20
>=20>  + case '^':
> >=20
>=20>  + val ^=3D val2;
> >=20
>=20>  + break;
> >=20
>=20>  + }
> >=20
>=20>  + }
> >=20
>=20>  + return val;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +static HMP_EXPR_INC_TY HMP_EXPR_INC_IDENT(expr_sum)(Monitor *mon)
> >=20
>=20>  +{
> >=20
>=20>  + HMP_EXPR_INC_TY val, val2;
> >=20
>=20>  + int op;
> >=20
>=20>  +
> >=20
>=20>  + val =3D HMP_EXPR_INC_IDENT(expr_logic)(mon);
> >=20
>=20>  + for (;;) {
> >=20
>=20>  + op =3D *pch;
> >=20
>=20>  + if (op !=3D '+' && op !=3D '-') {
> >=20
>=20>  + break;
> >=20
>=20>  + }
> >=20
>=20>  + next();
> >=20
>=20>  + val2 =3D HMP_EXPR_INC_IDENT(expr_logic)(mon);
> >=20
>=20>  + if (op =3D=3D '+') {
> >=20
>=20>  + val=20+=3D val2;
> >=20
>=20>  + } else {
> >=20
>=20>  + val -=3D val2;
> >=20
>=20>  + }
> >=20
>=20>  + }
> >=20
>=20>  + return val;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +static int HMP_EXPR_INC_IDENT(get_expr)(Monitor *mon, HMP_EXPR_IN=
C_TY *pval, const char **pp)
> >=20
>=20>  +{
> >=20
>=20>  + pch =3D *pp;
> >=20
>=20>  + if (sigsetjmp(expr_env, 0)) {
> >=20
>=20>  + *pp =3D pch;
> >=20
>=20>  + return -1;
> >=20
>=20>  + }
> >=20
>=20>  + while (qemu_isspace(*pch)) {
> >=20
>=20>  + pch++;
> >=20
>=20>  + }
> >=20
>=20>  + *pval =3D HMP_EXPR_INC_IDENT(expr_sum)(mon);
> >=20
>=20>  + *pp =3D pch;
> >=20
>=20>  + return 0;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +#undef HMP_EXPR_INC_TY
> >=20
>=20>  +#undef HMP_EXPR_INC_IDENT
> >=20
>=20>  diff --git a/monitor/hmp.c b/monitor/hmp.c
> >=20
>=20>  index 460e8832f6..95d965a20a 100644
> >=20
>=20>  --- a/monitor/hmp.c
> >=20
>=20>  +++ b/monitor/hmp.c
> >=20
>=20>  @@ -332,195 +332,13 @@ static void next(void)
> >=20
>=20>  }
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  -static int64_t expr_sum(Monitor *mon);
> >=20
>=20>  +#define HMP_EXPR_INC_TY int64_t
> >=20
>=20>  +#define HMP_EXPR_INC_IDENT(name) name ## _int64
> >=20
>=20>  +#include "monitor/hmp-expr.inc"
> >=20
>=20>=20=20
>=20>=20
>=20>  -static int64_t expr_unary(Monitor *mon)
> >=20
>=20>  -{
> >=20
>=20>  - int64_t n;
> >=20
>=20>  - char *p;
> >=20
>=20>  - int ret;
> >=20
>=20>  -
> >=20
>=20>  - switch (*pch) {
> >=20
>=20>  - case '+':
> >=20
>=20>  - next();
> >=20
>=20>  - n =3D expr_unary(mon);
> >=20
>=20>  - break;
> >=20
>=20>  - case '-':
> >=20
>=20>  - next();
> >=20
>=20>  - n =3D -expr_unary(mon);
> >=20
>=20>  - break;
> >=20
>=20>  - case '~':
> >=20
>=20>  - next();
> >=20
>=20>  - n =3D ~expr_unary(mon);
> >=20
>=20>  - break;
> >=20
>=20>  - case '(':
> >=20
>=20>  - next();
> >=20
>=20>  - n =3D expr_sum(mon);
> >=20
>=20>  - if (*pch !=3D ')') {
> >=20
>=20>  - expr_error(mon, "')' expected");
> >=20
>=20>  - }
> >=20
>=20>  - next();
> >=20
>=20>  - break;
> >=20
>=20>  - case '\'':
> >=20
>=20>  - pch++;
> >=20
>=20>  - if (*pch =3D=3D '\0') {
> >=20
>=20>  - expr_error(mon, "character constant expected");
> >=20
>=20>  - }
> >=20
>=20>  - n =3D *pch;
> >=20
>=20>  - pch++;
> >=20
>=20>  - if (*pch !=3D '\'') {
> >=20
>=20>  - expr_error(mon, "missing terminating \' character");
> >=20
>=20>  - }
> >=20
>=20>  - next();
> >=20
>=20>  - break;
> >=20
>=20>  - case '$':
> >=20
>=20>  - {
> >=20
>=20>  - char buf[128], *q;
> >=20
>=20>  - int64_t reg =3D 0;
> >=20
>=20>  -
> >=20
>=20>  - pch++;
> >=20
>=20>  - q =3D buf;
> >=20
>=20>  - while ((*pch >=3D 'a' && *pch <=3D 'z') ||
> >=20
>=20>  - (*pch >=3D 'A' && *pch <=3D 'Z') ||
> >=20
>=20>  - (*pch >=3D '0' && *pch <=3D '9') ||
> >=20
>=20>  - *pch =3D=3D '_' || *pch =3D=3D '.') {
> >=20
>=20>  - if ((q - buf) < sizeof(buf) - 1) {
> >=20
>=20>  - *q++ =3D *pch;
> >=20
>=20>  - }
> >=20
>=20>  - pch++;
> >=20
>=20>  - }
> >=20
>=20>  - while (qemu_isspace(*pch)) {
> >=20
>=20>  - pch++;
> >=20
>=20>  - }
> >=20
>=20>  - *q =3D 0;
> >=20
>=20>  - ret =3D get_monitor_def(mon, &reg, buf);
> >=20
>=20>  - if (ret < 0) {
> >=20
>=20>  - expr_error(mon, "unknown register");
> >=20
>=20>  - }
> >=20
>=20>  - n =3D reg;
> >=20
>=20>  - }
> >=20
>=20>  - break;
> >=20
>=20>  - case '\0':
> >=20
>=20>  - expr_error(mon, "unexpected end of expression");
> >=20
>=20>  - n =3D 0;
> >=20
>=20>  - break;
> >=20
>=20>  - default:
> >=20
>=20>  - errno =3D 0;
> >=20
>=20>  - n =3D strtoull(pch, &p, 0);
> >=20
>=20>  - if (errno =3D=3D ERANGE) {
> >=20
>=20>  - expr_error(mon, "number too large");
> >=20
>=20>  - }
> >=20
>=20>  - if (pch =3D=3D p) {
> >=20
>=20>  - expr_error(mon, "invalid char '%c' in expression", *p);
> >=20
>=20>  - }
> >=20
>=20>  - pch =3D p;
> >=20
>=20>  - while (qemu_isspace(*pch)) {
> >=20
>=20>  - pch++;
> >=20
>=20>  - }
> >=20
>=20>  - break;
> >=20
>=20>  - }
> >=20
>=20>  - return n;
> >=20
>=20>  -}
> >=20
>=20>  -
> >=20
>=20>  -static int64_t expr_prod(Monitor *mon)
> >=20
>=20>  -{
> >=20
>=20>  - int64_t val, val2;
> >=20
>=20>  - int op;
> >=20
>=20>  -
> >=20
>=20>  - val =3D expr_unary(mon);
> >=20
>=20>  - for (;;) {
> >=20
>=20>  - op =3D *pch;
> >=20
>=20>  - if (op !=3D '*' && op !=3D '/' && op !=3D '%') {
> >=20
>=20>  - break;
> >=20
>=20>  - }
> >=20
>=20>  - next();
> >=20
>=20>  - val2 =3D expr_unary(mon);
> >=20
>=20>  - switch (op) {
> >=20
>=20>  - default:
> >=20
>=20>  - case '*':
> >=20
>=20>  - val *=3D val2;
> >=20
>=20>  - break;
> >=20
>=20>  - case '/':
> >=20
>=20>  - case '%':
> >=20
>=20>  - if (val2 =3D=3D 0) {
> >=20
>=20>  - expr_error(mon, "division by zero");
> >=20
>=20>  - }
> >=20
>=20>  - if (op =3D=3D '/') {
> >=20
>=20>  - val /=3D val2;
> >=20
>=20>  - } else {
> >=20
>=20>  - val %=3D val2;
> >=20
>=20>  - }
> >=20
>=20>  - break;
> >=20
>=20>  - }
> >=20
>=20>  - }
> >=20
>=20>  - return val;
> >=20
>=20>  -}
> >=20
>=20>  -
> >=20
>=20>  -static int64_t expr_logic(Monitor *mon)
> >=20
>=20>  -{
> >=20
>=20>  - int64_t val, val2;
> >=20
>=20>  - int op;
> >=20
>=20>  -
> >=20
>=20>  - val =3D expr_prod(mon);
> >=20
>=20>  - for (;;) {
> >=20
>=20>  - op =3D *pch;
> >=20
>=20>  - if (op !=3D '&' && op !=3D '|' && op !=3D '^') {
> >=20
>=20>  - break;
> >=20
>=20>  - }
> >=20
>=20>  - next();
> >=20
>=20>  - val2 =3D expr_prod(mon);
> >=20
>=20>  - switch (op) {
> >=20
>=20>  - default:
> >=20
>=20>  - case '&':
> >=20
>=20>  - val &=3D val2;
> >=20
>=20>  - break;
> >=20
>=20>  - case '|':
> >=20
>=20>  - val |=3D val2;
> >=20
>=20>  - break;
> >=20
>=20>  - case '^':
> >=20
>=20>  - val ^=3D val2;
> >=20
>=20>  - break;
> >=20
>=20>  - }
> >=20
>=20>  - }
> >=20
>=20>  - return val;
> >=20
>=20>  -}
> >=20
>=20>  -
> >=20
>=20>  -static int64_t expr_sum(Monitor *mon)
> >=20
>=20>  -{
> >=20
>=20>  - int64_t val, val2;
> >=20
>=20>  - int op;
> >=20
>=20>  -
> >=20
>=20>  - val =3D expr_logic(mon);
> >=20
>=20>  - for (;;) {
> >=20
>=20>  - op =3D *pch;
> >=20
>=20>  - if (op !=3D '+' && op !=3D '-') {
> >=20
>=20>  - break;
> >=20
>=20>  - }
> >=20
>=20>  - next();
> >=20
>=20>  - val2 =3D expr_logic(mon);
> >=20
>=20>  - if (op =3D=3D '+') {
> >=20
>=20>  - val +=3D val2;
> >=20
>=20>  - } else {
> >=20
>=20>  - val -=3D val2;
> >=20
>=20>  - }
> >=20
>=20>  - }
> >=20
>=20>  - return val;
> >=20
>=20>  -}
> >=20
>=20>  -
> >=20
>=20>  -static int get_expr(Monitor *mon, int64_t *pval, const char **pp)
> >=20
>=20>  -{
> >=20
>=20>  - pch =3D *pp;
> >=20
>=20>  - if (sigsetjmp(expr_env, 0)) {
> >=20
>=20>  - *pp =3D pch;
> >=20
>=20>  - return -1;
> >=20
>=20>  - }
> >=20
>=20>  - while (qemu_isspace(*pch)) {
> >=20
>=20>  - pch++;
> >=20
>=20>  - }
> >=20
>=20>  - *pval =3D expr_sum(mon);
> >=20
>=20>  - *pp =3D pch;
> >=20
>=20>  - return 0;
> >=20
>=20>  -}
> >=20
>=20>  +#define HMP_EXPR_INC_TY uint64_t
> >=20
>=20>  +#define HMP_EXPR_INC_IDENT(name) name ## _uint64
> >=20
>=20>  +#include "monitor/hmp-expr.inc"
> >=20
>=20>=20=20
>=20>=20
>=20>  static int get_double(Monitor *mon, double *pval, const char **pp)
> >=20
>=20>  {
> >=20
>=20>  @@ -882,7 +700,7 @@ static QDict *monitor_parse_arguments(Monitor =
*mon,
> >=20
>=20>  }
> >=20
>=20>  typestr++;
> >=20
>=20>  }
> >=20
>=20>  - if (get_expr(mon, &val, &p)) {
> >=20
>=20>  + if (get_expr_int64(mon, &val, &p)) {
> >=20
>=20>  goto fail;
> >=20
>=20>  }
> >=20
>=20>  /* Check if 'i' is greater than 32-bit */
> >=20
>=20>  @@ -900,6 +718,51 @@ static QDict *monitor_parse_arguments(Monitor=
 *mon,
> >=20
>=20>  qdict_put_int(qdict, key, val);
> >=20
>=20>  }
> >=20
>=20>  break;
> >=20
>=20>  + case 'd':
> >=20
>=20>  + case 'u':
> >=20
>=20>  + case 'm':
> >=20
>=20>  + {
> >=20
>=20>  + uint64_t val;
> >=20
>=20>  +
> >=20
>=20>  + while (qemu_isspace(*p)) {
> >=20
>=20>  + p++;
> >=20
>=20>  + }
> >=20
>=20>  + if (*typestr =3D=3D '?' || *typestr =3D=3D '.') {
> >=20
>=20>  + if (*typestr =3D=3D '?') {
> >=20
>=20>  + if (*p =3D=3D '\0') {
> >=20
>=20>  + typestr++;
> >=20
>=20>  + break;
> >=20
>=20>  + }
> >=20
>=20>  + } else {
> >=20
>=20>  + if (*p =3D=3D '.') {
> >=20
>=20>  + p++;
> >=20
>=20>  + while (qemu_isspace(*p)) {
> >=20
>=20>  + p++;
> >=20
>=20>  + }
> >=20
>=20>  + } else {
> >=20
>=20>  + typestr++;
> >=20
>=20>  + break;
> >=20
>=20>  + }
> >=20
>=20>  + }
> >=20
>=20>  + typestr++;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + if (get_expr_uint64(mon, &val, &p)) {
> >=20
>=20>  + goto fail;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + /* Check if 'd' is greater than 32-bit */
> >=20
>=20>  + if ((c =3D=3D 'd') && ((val >> 32) & 0xffffffff)) {
> >=20
>=20>  + monitor_printf(mon, "\'%s\' has failed: ", cmd->name);
> >=20
>=20>  + monitor_printf(mon, "integer is for 32-bit values\n");
> >=20
>=20>  + goto fail;
> >=20
>=20>  + } else if (c =3D=3D 'm') {
> >=20
>=20>  + val *=3D MiB;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + qdict_put_uint(qdict, key, val);
> >=20
>=20>  + }
> >=20
>=20>  + break;
> >=20
>=20>  case 'o':
> >=20
>=20>  {
> >=20
>=20>  int ret;
> >=20
>=20>  diff --git a/qapi/machine.json b/qapi/machine.json
> >=20
>=20>  index fcfd249e2d..7c2627c3e2 100644
> >=20
>=20>  --- a/qapi/machine.json
> >=20
>=20>  +++ b/qapi/machine.json
> >=20
>=20>  @@ -825,6 +825,44 @@
> >=20
>=20>  'policy': 'HmatCacheWritePolicy',
> >=20
>=20>  'line': 'uint16' }}
> >=20
>=20>=20=20
>=20>=20
>=20>  +##
> >=20
>=20>  +# @MemTranslation:
> >=20
>=20>  +#
> >=20
>=20>  +# Result of a virtual-to-physical memory translation via @memtran=
slate.
> >=20
>=20>  +#
> >=20
>=20>  +# @phys: the physical address corresponding to the virtual addres=
s,
> >=20
>=20>  +# or -1 if the translation failed
> >=20
>=20>  +#
> >=20
>=20>  +# Since: TBD
> >=20
>=20>  +##
> >=20
>=20>  +{ 'struct': 'MemTranslation',
> >=20
>=20>  + 'data': { 'phys': 'uint64' } }
> >=20
>=20>  +
> >=20
>=20>  +##
> >=20
>=20>  +# @memtranslate:
> >=20
>=20>  +#
> >=20
>=20>  +# Translate a guest virtual address to a physical address.
> >=20
>=20>  +#
> >=20
>=20>  +# @val: the virtual address of the guest to translate
> >=20
>=20>  +#
> >=20
>=20>  +# @cpu-index: the index of the virtual CPU to use for translating=
 the
> >=20
>=20>  +# virtual address (defaults to CPU 0)
> >=20
>=20>  +#
> >=20
>=20>  +# Returns:
> >=20
>=20>  +# @MemTranslation
> >=20
>=20>  +#
> >=20
>=20>  +# Since: TBD
> >=20
>=20>  +#
> >=20
>=20>  +# .. qmp-example::
> >=20
>=20>  +#
> >=20
>=20>  +# -> { "execute": "memtranslate",
> >=20
>=20>  +# "arguments": { "val": 10 } }
> >=20
>=20>  +# <- { "return": { "phys": 20 } }
> >=20
>=20>  +##
> >=20
>=20>  +{ 'command': 'memtranslate',
> >=20
>=20>  + 'data': {'val': 'uint64', '*cpu-index': 'int'},
> >=20
>=20>  + 'returns': 'MemTranslation' }
> >=20
>=20>  +
> >=20
>=20>  ##
> >=20
>=20>  # @memsave:
> >=20
>=20>  #
> >=20
>=20>  @@ -852,7 +890,7 @@
> >=20
>=20>  # <- { "return": {} }
> >=20
>=20>  ##
> >=20
>=20>  { 'command': 'memsave',
> >=20
>=20>  - 'data': {'val': 'int', 'size': 'int', 'filename': 'str', '*cpu-i=
ndex': 'int'} }
> >=20
>=20>  + 'data': {'val': 'uint64', 'size': 'uint64', 'filename': 'str', '=
*cpu-index': 'int'} }
> >=20
>=20>=20=20
>=20>=20
>=20>  ##
> >=20
>=20>  # @pmemsave:
> >=20
>=20>  @@ -878,7 +916,7 @@
> >=20
>=20>  # <- { "return": {} }
> >=20
>=20>  ##
> >=20
>=20>  { 'command': 'pmemsave',
> >=20
>=20>  - 'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
> >=20
>=20>  + 'data': {'val': 'uint64', 'size': 'uint64', 'filename': 'str'} }
> >=20
>=20>=20=20
>=20>=20
>=20>  ##
> >=20
>=20>  # @Memdev:
> >=20
>=20>  diff --git a/qobject/qdict.c b/qobject/qdict.c
> >=20
>=20>  index 8faff230d3..9696eee57d 100644
> >=20
>=20>  --- a/qobject/qdict.c
> >=20
>=20>  +++ b/qobject/qdict.c
> >=20
>=20>  @@ -136,6 +136,11 @@ void qdict_put_int(QDict *qdict, const char *=
key, int64_t value)
> >=20
>=20>  qdict_put(qdict, key, qnum_from_int(value));
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  +void qdict_put_uint(QDict *qdict, const char *key, uint64_t value=
)
> >=20
>=20>  +{
> >=20
>=20>  + qdict_put(qdict, key, qnum_from_uint(value));
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  void qdict_put_bool(QDict *qdict, const char *key, bool value)
> >=20
>=20>  {
> >=20
>=20>  qdict_put(qdict, key, qbool_from_bool(value));
> >=20
>=20>  @@ -209,6 +214,19 @@ int64_t qdict_get_int(const QDict *qdict, con=
st char *key)
> >=20
>=20>  return qnum_get_int(qobject_to(QNum, qdict_get(qdict, key)));
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  +/**
> >=20
>=20>  + * qdict_get_int(): Get an unsigned integer mapped by 'key'
> >=20
>=20>  + *
> >=20
>=20>  + * This function assumes that 'key' exists and it stores a
> >=20
>=20>  + * QNum representable as uint.
> >=20
>=20>  + *
> >=20
>=20>  + * Return integer mapped by 'key'.
> >=20
>=20>  + */
> >=20
>=20>  +uint64_t qdict_get_uint(const QDict *qdict, const char *key)
> >=20
>=20>  +{
> >=20
>=20>  + return qnum_get_uint(qobject_to(QNum, qdict_get(qdict, key)));
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  /**
> >=20
>=20>  * qdict_get_bool(): Get a bool mapped by 'key'
> >=20
>=20>  *
> >=20
>=20>  @@ -272,6 +290,26 @@ int64_t qdict_get_try_int(const QDict *qdict,=
 const char *key,
> >=20
>=20>  return val;
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  +/**
> >=20
>=20>  + * qdict_get_try_uint(): Try to get unsigned integer mapped by 'k=
ey'
> >=20
>=20>  + *
> >=20
>=20>  + * Return integer mapped by 'key', if it is not present in the
> >=20
>=20>  + * dictionary or if the stored object is not a QNum representing =
an
> >=20
>=20>  + * unsigned integer, 'def_value' will be returned.
> >=20
>=20>  + */
> >=20
>=20>  +uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
> >=20
>=20>  + uint64_t def_value)
> >=20
>=20>  +{
> >=20
>=20>  + QNum *qnum =3D qobject_to(QNum, qdict_get(qdict, key));
> >=20
>=20>  + uint64_t val;
> >=20
>=20>  +
> >=20
>=20>  + if (!qnum || !qnum_get_try_uint(qnum, &val)) {
> >=20
>=20>  + return def_value;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + return val;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  /**
> >=20
>=20>  * qdict_get_try_bool(): Try to get a bool mapped by 'key'
> >=20
>=20>  *
> >=20
>=20>  diff --git a/system/cpus.c b/system/cpus.c
> >=20
>=20>  index 5e3a988a0a..25d7d7c93f 100644
> >=20
>=20>  --- a/system/cpus.c
> >=20
>=20>  +++ b/system/cpus.c
> >=20
>=20>  @@ -792,7 +792,34 @@ int vm_stop_force_state(RunState state)
> >=20
>=20>  }
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  -void qmp_memsave(int64_t addr, int64_t size, const char *filename=
,
> >=20
>=20>  +MemTranslation *qmp_memtranslate(uint64_t val, bool has_cpu_index=
, int64_t cpu_index, Error **errp)
> >=20
>=20>  +{
> >=20
>=20>  + CPUState *cpu;
> >=20
>=20>  + hwaddr phys_addr;
> >=20
>=20>  + MemTxAttrs attrs;
> >=20
>=20>  + MemTranslation *translation;
> >=20
>=20>  +
> >=20
>=20>  + if (!has_cpu_index) {
> >=20
>=20>  + cpu_index =3D 0;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + cpu =3D qemu_get_cpu(cpu_index);
> >=20
>=20>  + if (cpu =3D=3D NULL) {
> >=20
>=20>  + error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
> >=20
>=20>  + "a CPU number");
> >=20
>=20>  + return NULL;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + phys_addr =3D cpu_memory_translate(cpu, val, &attrs);
> >=20
>=20>  +
> >=20
>=20>  + translation =3D g_new0(MemTranslation, 1);
> >=20
>=20>  +
> >=20
>=20>  + translation->phys =3D phys_addr;
> >=20
>=20>  +
> >=20
>=20>  + return translation;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +void qmp_memsave(uint64_t addr, uint64_t size, const char *filena=
me,
> >=20
>=20>  bool has_cpu, int64_t cpu_index, Error **errp)
> >=20
>=20>  {
> >=20
>=20>  FILE *f;
> >=20
>=20>  @@ -840,7 +867,7 @@ exit:
> >=20
>=20>  fclose(f);
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  -void qmp_pmemsave(int64_t addr, int64_t size, const char *filenam=
e,
> >=20
>=20>  +void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filen=
ame,
> >=20
>=20>  Error **errp)
> >=20
>=20>  {
> >=20
>=20>  FILE *f;
> >=20
>=20>  diff --git a/system/physmem.c b/system/physmem.c
> >=20
>=20>  index 0e19186e1b..d2fab35e3a 100644
> >=20
>=20>  --- a/system/physmem.c
> >=20
>=20>  +++ b/system/physmem.c
> >=20
>=20>  @@ -3524,6 +3524,24 @@ address_space_write_cached_slow(MemoryRegio=
nCache *cache, hwaddr addr,
> >=20
>=20>  #define RCU_READ_UNLOCK() ((void)0)
> >=20
>=20>  #include "memory_ldst.c.inc"
> >=20
>=20>=20=20
>=20>=20
>=20>  +/* virtual memory translation */
> >=20
>=20>  +hwaddr cpu_memory_translate(CPUState *cpu, vaddr addr, MemTxAttrs=
 *attrs)
> >=20
>=20>  +{
> >=20
>=20>  + hwaddr phys_addr, phys_addr_rel;
> >=20
>=20>  + vaddr page;
> >=20
>=20>  +
> >=20
>=20>  + page =3D addr & TARGET_PAGE_MASK;
> >=20
>=20>  + phys_addr =3D cpu_get_phys_page_attrs_debug(cpu, page, attrs);
> >=20
>=20>  +
> >=20
>=20>  + if (phys_addr =3D=3D -1) {
> >=20
>=20>  + return -1;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + phys_addr_rel =3D phys_addr + (addr & ~TARGET_PAGE_MASK);
> >=20
>=20>  +
> >=20
>=20>  + return phys_addr_rel;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  /* virtual memory access for debug (includes writing to ROM) */
> >=20
>=20>  int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
> >=20
>=20>  void *ptr, size_t len, bool is_write)
> >=20
>=20>  diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
> >=20
>=20>  index 1b2e07522f..13c45deb35 100644
> >=20
>=20>  --- a/tests/qtest/test-hmp.c
> >=20
>=20>  +++ b/tests/qtest/test-hmp.c
> >=20
>=20>  @@ -44,6 +44,7 @@ static const char *hmp_cmds[] =3D {
> >=20
>=20>  "i /w 0",
> >=20
>=20>  "log all",
> >=20
>=20>=20=20"log none",
> >=20
>=20>  + "memtranslate 0",
> >=20
>=20>  "memsave 0 4096 \"/dev/null\"",
> >=20
>=20>  "migrate_set_parameter xbzrle-cache-size 64k",
> >=20
>=20>  "migrate_set_parameter downtime-limit 1",
> >=20
>=20>  diff --git a/tests/unit/check-qdict.c b/tests/unit/check-qdict.c
> >=20
>=20>  index b5efa859b0..09ebe08900 100644
> >=20
>=20>  --- a/tests/unit/check-qdict.c
> >=20
>=20>  +++ b/tests/unit/check-qdict.c
> >=20
>=20>  @@ -99,6 +99,21 @@ static void qdict_get_int_test(void)
> >=20
>=20>  qobject_unref(tests_dict);
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  +static void qdict_get_uint_test(void)
> >=20
>=20>  +{
> >=20
>=20>  + int ret;
> >=20
>=20>  + const unsigned int value =3D 100;
> >=20
>=20>  + const char *key =3D "int";
> >=20
>=20>  + QDict *tests_dict =3D qdict_new();
> >=20
>=20>  +
> >=20
>=20>  + qdict_put_uint(tests_dict, key, value);
> >=20
>=20>  +
> >=20
>=20>  + ret =3D qdict_get_uint(tests_dict, key);
> >=20
>=20>  + g_assert(ret =3D=3D value);
> >=20
>=20>  +
> >=20
>=20>  + qobject_unref(tests_dict);
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  static void qdict_get_try_int_test(void)
> >=20
>=20>  {
> >=20
>=20>  int ret;
> >=20
>=20>  @@ -121,6 +136,28 @@ static void qdict_get_try_int_test(void)
> >=20
>=20>  qobject_unref(tests_dict);
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  +static void qdict_get_try_uint_test(void)
> >=20
>=20>  +{
> >=20
>=20>  + int ret;
> >=20
>=20>  + const unsigned int value =3D 100;
> >=20
>=20>  + const char *key =3D "int";
> >=20
>=20>  + QDict *tests_dict =3D qdict_new();
> >=20
>=20>  +
> >=20
>=20>  + qdict_put_uint(tests_dict, key, value);
> >=20
>=20>  + qdict_put_str(tests_dict, "string", "test");
> >=20
>=20>  +
> >=20
>=20>  + ret =3D qdict_get_try_uint(tests_dict, key, 0);
> >=20
>=20>  + g_assert(ret =3D=3D value);
> >=20
>=20>  +
> >=20
>=20>  + ret =3D qdict_get_try_uint(tests_dict, "missing", -42);
> >=20
>=20>  + g_assert_cmpuint(ret, =3D=3D, -42);
> >=20
>=20>  +
> >=20
>=20>  + ret =3D qdict_get_try_uint(tests_dict, "string", -42);
> >=20
>=20>  + g_assert_cmpuint(ret, =3D=3D, -42);
> >=20
>=20>  +
> >=20
>=20>  + qobject_unref(tests_dict);
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  static void qdict_get_str_test(void)
> >=20
>=20>  {
> >=20
>=20>  const char *p;
> >=20
>=20>  @@ -358,7 +395,9 @@ int main(int argc, char **argv)
> >=20
>=20>  /* Continue, but now with fixtures */
> >=20
>=20>  g_test_add_func("/public/get", qdict_get_test);
> >=20
>=20>  g_test_add_func("/public/get_int", qdict_get_int_test);
> >=20
>=20>  + g_test_add_func("/public/get_uint", qdict_get_uint_test);
> >=20
>=20>  g_test_add_func("/public/get_try_int", qdict_get_try_int_test);
> >=20
>=20>  + g_test_add_func("/public/get_try_uint", qdict_get_try_uint_test)=
;
> >=20
>=20>  g_test_add_func("/public/get_str", qdict_get_str_test);
> >=20
>=20>  g_test_add_func("/public/get_try_str", qdict_get_try_str_test);
> >=20
>=20>  g_test_add_func("/public/haskey_not", qdict_haskey_not_test);
> >=20
>=20>  --=20
>=20>=20
>=20>  2.34.1
> >=20
>=20
> --=20
>=20
>  -----Open up your eyes, open up your mind, open up your code -------=
=20
>=20
> / Dr. David Alan Gilbert | Running GNU/Linux | Happy \=20
>=20
> \ dave @ treblig.org | | In Hex /
>=20
>=20 \ _________________________|_____ http://www.treblig.org/ |_______/
>

