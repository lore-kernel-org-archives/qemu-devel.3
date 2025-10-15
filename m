Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A476ECCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 03:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8sKw-0006aj-NQ; Tue, 14 Oct 2025 23:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8sKt-0006aR-Ce
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 23:37:59 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8sKm-0004av-8g
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 23:37:59 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59F3ba6e082441
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 15 Oct 2025 12:37:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=oI4OmrcM6/Ucne+KDAmYK/NyqtKj23CXrGG8MqWGDEA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1760499457; v=1;
 b=hVCmpAG5+CL0TS0VhH8KZjzGoWXlODgokXTO9Pi3AwO1XYkmhFXiBIJnlbptv1d7
 Eqp2/QbuxBF37u/0uMoYlpPTepymjxivNot/aeinXs10Fd6LUxFEmPGJdlKdd7xA
 sFhALSuRxt4ClDoj+9Cncqu60sn6pdTD+d3tyqd5rrTSfiieB7iDawH94bkIwc0/
 zdg/fvlHSS8yEsphnKxwvkexeC93SbB8i4/R8wMUwgBQmwEoVgjrZ0n1sOkQZ4Vy
 N5nAqKjsQTixHC965kgX9q58gb41liVn5sE1UrI1IPQNOM+HtnA2CSOermuOExUl
 nzCmQJQseOjl4/8mv7OBkA==
Message-ID: <0f069bb5-dc6a-4b1c-a1f2-0f7e7710d988@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 15 Oct 2025 12:37:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] system/memory: add memory_region_finalize tracepoint
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
 <20251014111234.3190346-3-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251014111234.3190346-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/10/14 20:12, Alex Bennée wrote:
> This only traces named memory regions as it is otherwise quite noisy
> every time the address map changes.

Checking for name does not seem effective to reduce noises. I used 
Coccinelle and found there are only three instances of unnamed memory 
regions. The three instances are:

- memory_region_init_alias() in xen_gnttab_realize()
- memory_region_init_io() in subpage_init()
- memory_region_init_io() in io_mem_init()

The command line I used is as follows:
spatch --macro-file scripts/cocci-macro-file.h --sp-file 
./scripts/coccinelle/a.cocci --keep-comments --in-place --use-gitgrep 
--dir .

Below is the content of scripts/coccinelle/a.cocci:

@filter@
expression a, b, c, d;
position p;
@@

(
  memory_region_init@p(a, b, NULL, ...);
|
  memory_region_init_io@p(a, b, c, d, NULL, ...);
|
  memory_region_init_ram_nomigrate@p(a, b, NULL, ...);
|
  memory_region_init_ram_flags_nomigrate@p(a, b, NULL, ...);
|
  memory_region_init_resizeable_ram@p(a, b, NULL, ...);
|
  memory_region_init_ram_from_file@p(a, b, NULL, ...);
|
  memory_region_init_ram_from_fd@p(a, b, NULL, ...);
|
  memory_region_init_ram_ptr@p(a, b, NULL, ...);
|
  memory_region_init_ram_device_ptr@p(a, b, NULL, ...);
|
  memory_region_init_alias@p(a, b, NULL, ...);
|
  memory_region_init_rom_nomigrate@p(a, b, NULL, ...);
|
  memory_region_init_rom_device_nomigrate@p(a, b, c, d, NULL, ...);
|
  memory_region_init_iommu@p(a, b, c, d, NULL, ...);
|
  memory_region_init_ram@p(a, b, NULL, ...);
|
  memory_region_init_ram_guest_memfd@p(a, b, NULL, ...);
|
  memory_region_init_rom@p(a, b, NULL, ...);
|
  memory_region_init_rom_device@p(a, b, c, d, NULL, ...);
)

@script:python@
p << filter.p;
@@

cocci.print_main("found", p)


> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   system/memory.c     | 5 +++++
>   system/trace-events | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 8b84661ae36..fd7c3192ed4 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1821,6 +1821,11 @@ static void memory_region_finalize(Object *obj)
>        * memory_region_set_enabled instead could trigger a transaction and
>        * cause an infinite loop.
>        */
> +
> +    if (mr->name) {
> +        trace_memory_region_finalize(mr, mr->name);
> +    }
> +
>       mr->enabled = false;
>       memory_region_transaction_begin();
>       if (mr->container) {
> diff --git a/system/trace-events b/system/trace-events
> index 82856e44f2e..a8ef2326e14 100644
> --- a/system/trace-events
> +++ b/system/trace-events
> @@ -23,6 +23,7 @@ memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t v
>   memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
>   memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
>   memory_region_sync_dirty(const char *mr, const char *listener, int global) "mr '%s' listener '%s' synced (global=%d)"
> +memory_region_finalize(void *mr, const char *name) "mr %p, %s"
>   flatview_new(void *view, void *root) "%p (root %p)"
>   flatview_destroy(void *view, void *root) "%p (root %p)"
>   flatview_destroy_rcu(void *view, void *root) "%p (root %p)"


