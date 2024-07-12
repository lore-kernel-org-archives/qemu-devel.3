Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D767EC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBif-0000N4-8d; Fri, 12 Jul 2024 04:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBic-0000DG-TD
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBiY-0006wX-NG
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WH1+BMXyZO+Z0WNjA4h1BskDdR6psNfZiAznnYH5d+M=;
 b=BSPAx83dE7IeY9jVtamaqdakR81asmBHY7MX9yxr7HLFQ7OVKK4O5DpJ6LZxBb8PYyLI6R
 7WcPiMOP8zM5kgCvZA9hb6nTfhdvpccdvJryWsEoAkmS5U6Ng4jJQ307vSnyzn+81tOuYc
 oZc+NI5S4P9wyIGH1xO3Qa1h2dc3X2A=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-nQCYiIJjO-OVgcyOGLPXvA-1; Fri, 12 Jul 2024 04:33:23 -0400
X-MC-Unique: nQCYiIJjO-OVgcyOGLPXvA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e03a544b9c8so2915912276.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773203; x=1721378003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WH1+BMXyZO+Z0WNjA4h1BskDdR6psNfZiAznnYH5d+M=;
 b=hrCxi2Ib51oOwHFdgTXYGhb6Gx1wB02/0dfgCdxUtkmElikeT2TNivXrjm9OuDuzpB
 ytyzw/6ESJCBa8IHMPBentrGVYnKS5v+WpnCx4ga1EdtNib0zYy4C6xnVGRH6dFdZ/j5
 0tzwqAJJ6+4Rv5apBAEwJMe71IKT27JpMmyQx1R7OCA6o1xsu37bojTc+ZLxMUjYnFTx
 j57qT+HNYE6DuUMbJ1rEv3YK2VARpTyrbLZ9E5RrwIcPSHBlExaosgun9bRXf1M8X3hv
 9oLHnvm/Yi/cXpQZBMPC32bvBsiJvFo8kbUXf9lPxI+0tgQ3BQeO4iDRYhjq3aP2YTHe
 iApA==
X-Gm-Message-State: AOJu0YzdaYoup4TdnZjJrnt2uQSZtyP1NkBy+a56sn8gGPscTh0bG7dS
 RTO1MYiUnpsI+7GKnRGtHeg8GANJsGQsjqjLkdh99a66HaFh0s12D66HuelAI6oAmAzY71JBLYE
 8SdjZbX0+1+170cWSB165/Z4Bf7nybnpghpGOMYVMQbQ+o7ZCeN2U4WkEB3xV7zg10aBibRdsqx
 Oy2D3Ub83155ZeU7HH0s8ZOzTiQMs=
X-Received: by 2002:a25:ae12:0:b0:e03:650c:228 with SMTP id
 3f1490d57ef6-e041b1c6f01mr12345154276.53.1720773203125; 
 Fri, 12 Jul 2024 01:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXJkWVAauz0sUJI4cweNLzhd3R4I4Z2a22ebiRt9rDqYZAR9lMS3t+d7UBO/6/hX+0ADCPV8FG5CnyvPQ1hlg=
X-Received: by 2002:a25:ae12:0:b0:e03:650c:228 with SMTP id
 3f1490d57ef6-e041b1c6f01mr12345139276.53.1720773202798; Fri, 12 Jul 2024
 01:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613150127.1361931-6-berrange@redhat.com>
In-Reply-To: <20240613150127.1361931-6-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:33:12 +0300
Message-ID: <CAPMcbCp94iSXoAewPk7N3B0JWESDtzYhcU=80YStPsaXEPMQrQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/22] qga: move linux disk/cpu stats command impls to
 commands-linux.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007e04da061d08bbc5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000007e04da061d08bbc5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The qmp_guest_{diskstats,cpustats} command impls in
> commands-posix.c are surrounded by '#ifdef __linux__' so should
> instead live in commands-linux.c
>
> This also removes a "#ifdef CONFIG_LINUX" that was nested inside
> a "#ifdef __linux__".
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-linux.c | 195 ++++++++++++++++++++++++++++++++++++++++++
>  qga/commands-posix.c | 199 -------------------------------------------
>  2 files changed, 195 insertions(+), 199 deletions(-)
>
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 084e6c9e85..c0e8bd4062 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -1594,3 +1594,198 @@ int64_t
> qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
>
>      return processed;
>  }
> +
> +#define MAX_NAME_LEN 128
> +static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)
> +{
> +    GuestDiskStatsInfoList *head =3D NULL, **tail =3D &head;
> +    const char *diskstats =3D "/proc/diskstats";
> +    FILE *fp;
> +    size_t n;
> +    char *line =3D NULL;
> +
> +    fp =3D fopen(diskstats, "r");
> +    if (fp  =3D=3D NULL) {
> +        error_setg_errno(errp, errno, "open(\"%s\")", diskstats);
> +        return NULL;
> +    }
> +
> +    while (getline(&line, &n, fp) !=3D -1) {
> +        g_autofree GuestDiskStatsInfo *diskstatinfo =3D NULL;
> +        g_autofree GuestDiskStats *diskstat =3D NULL;
> +        char dev_name[MAX_NAME_LEN];
> +        unsigned int ios_pgr, tot_ticks, rq_ticks, wr_ticks, dc_ticks,
> fl_ticks;
> +        unsigned long rd_ios, rd_merges_or_rd_sec, rd_ticks_or_wr_sec,
> wr_ios;
> +        unsigned long wr_merges, rd_sec_or_wr_ios, wr_sec;
> +        unsigned long dc_ios, dc_merges, dc_sec, fl_ios;
> +        unsigned int major, minor;
> +        int i;
> +
> +        i =3D sscanf(line, "%u %u %s %lu %lu %lu"
> +                   "%lu %lu %lu %lu %u %u %u %u"
> +                   "%lu %lu %lu %u %lu %u",
> +                   &major, &minor, dev_name,
> +                   &rd_ios, &rd_merges_or_rd_sec, &rd_sec_or_wr_ios,
> +                   &rd_ticks_or_wr_sec, &wr_ios, &wr_merges, &wr_sec,
> +                   &wr_ticks, &ios_pgr, &tot_ticks, &rq_ticks,
> +                   &dc_ios, &dc_merges, &dc_sec, &dc_ticks,
> +                   &fl_ios, &fl_ticks);
> +
> +        if (i < 7) {
> +            continue;
> +        }
> +
> +        diskstatinfo =3D g_new0(GuestDiskStatsInfo, 1);
> +        diskstatinfo->name =3D g_strdup(dev_name);
> +        diskstatinfo->major =3D major;
> +        diskstatinfo->minor =3D minor;
> +
> +        diskstat =3D g_new0(GuestDiskStats, 1);
> +        if (i =3D=3D 7) {
> +            diskstat->has_read_ios =3D true;
> +            diskstat->read_ios =3D rd_ios;
> +            diskstat->has_read_sectors =3D true;
> +            diskstat->read_sectors =3D rd_merges_or_rd_sec;
> +            diskstat->has_write_ios =3D true;
> +            diskstat->write_ios =3D rd_sec_or_wr_ios;
> +            diskstat->has_write_sectors =3D true;
> +            diskstat->write_sectors =3D rd_ticks_or_wr_sec;
> +        }
> +        if (i >=3D 14) {
> +            diskstat->has_read_ios =3D true;
> +            diskstat->read_ios =3D rd_ios;
> +            diskstat->has_read_sectors =3D true;
> +            diskstat->read_sectors =3D rd_sec_or_wr_ios;
> +            diskstat->has_read_merges =3D true;
> +            diskstat->read_merges =3D rd_merges_or_rd_sec;
> +            diskstat->has_read_ticks =3D true;
> +            diskstat->read_ticks =3D rd_ticks_or_wr_sec;
> +            diskstat->has_write_ios =3D true;
> +            diskstat->write_ios =3D wr_ios;
> +            diskstat->has_write_sectors =3D true;
> +            diskstat->write_sectors =3D wr_sec;
> +            diskstat->has_write_merges =3D true;
> +            diskstat->write_merges =3D wr_merges;
> +            diskstat->has_write_ticks =3D true;
> +            diskstat->write_ticks =3D wr_ticks;
> +            diskstat->has_ios_pgr =3D true;
> +            diskstat->ios_pgr =3D ios_pgr;
> +            diskstat->has_total_ticks =3D true;
> +            diskstat->total_ticks =3D tot_ticks;
> +            diskstat->has_weight_ticks =3D true;
> +            diskstat->weight_ticks =3D rq_ticks;
> +        }
> +        if (i >=3D 18) {
> +            diskstat->has_discard_ios =3D true;
> +            diskstat->discard_ios =3D dc_ios;
> +            diskstat->has_discard_merges =3D true;
> +            diskstat->discard_merges =3D dc_merges;
> +            diskstat->has_discard_sectors =3D true;
> +            diskstat->discard_sectors =3D dc_sec;
> +            diskstat->has_discard_ticks =3D true;
> +            diskstat->discard_ticks =3D dc_ticks;
> +        }
> +        if (i >=3D 20) {
> +            diskstat->has_flush_ios =3D true;
> +            diskstat->flush_ios =3D fl_ios;
> +            diskstat->has_flush_ticks =3D true;
> +            diskstat->flush_ticks =3D fl_ticks;
> +        }
> +
> +        diskstatinfo->stats =3D g_steal_pointer(&diskstat);
> +        QAPI_LIST_APPEND(tail, diskstatinfo);
> +        diskstatinfo =3D NULL;
> +    }
> +    free(line);
> +    fclose(fp);
> +    return head;
> +}
> +
> +GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
> +{
> +    return guest_get_diskstats(errp);
> +}
> +
> +GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
> +{
> +    GuestCpuStatsList *head =3D NULL, **tail =3D &head;
> +    const char *cpustats =3D "/proc/stat";
> +    int clk_tck =3D sysconf(_SC_CLK_TCK);
> +    FILE *fp;
> +    size_t n;
> +    char *line =3D NULL;
> +
> +    fp =3D fopen(cpustats, "r");
> +    if (fp  =3D=3D NULL) {
> +        error_setg_errno(errp, errno, "open(\"%s\")", cpustats);
> +        return NULL;
> +    }
> +
> +    while (getline(&line, &n, fp) !=3D -1) {
> +        GuestCpuStats *cpustat =3D NULL;
> +        GuestLinuxCpuStats *linuxcpustat;
> +        int i;
> +        unsigned long user, system, idle, iowait, irq, softirq, steal,
> guest;
> +        unsigned long nice, guest_nice;
> +        char name[64];
> +
> +        i =3D sscanf(line, "%s %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
> +                   name, &user, &nice, &system, &idle, &iowait, &irq,
> &softirq,
> +                   &steal, &guest, &guest_nice);
> +
> +        /* drop "cpu 1 2 3 ...", get "cpuX 1 2 3 ..." only */
> +        if ((i =3D=3D EOF) || strncmp(name, "cpu", 3) || (name[3] =3D=3D=
 '\0')) {
> +            continue;
> +        }
> +
> +        if (i < 5) {
> +            slog("Parsing cpu stat from %s failed, see \"man proc\"",
> cpustats);
> +            break;
> +        }
> +
> +        cpustat =3D g_new0(GuestCpuStats, 1);
> +        cpustat->type =3D GUEST_CPU_STATS_TYPE_LINUX;
> +
> +        linuxcpustat =3D &cpustat->u.q_linux;
> +        linuxcpustat->cpu =3D atoi(&name[3]);
> +        linuxcpustat->user =3D user * 1000 / clk_tck;
> +        linuxcpustat->nice =3D nice * 1000 / clk_tck;
> +        linuxcpustat->system =3D system * 1000 / clk_tck;
> +        linuxcpustat->idle =3D idle * 1000 / clk_tck;
> +
> +        if (i > 5) {
> +            linuxcpustat->has_iowait =3D true;
> +            linuxcpustat->iowait =3D iowait * 1000 / clk_tck;
> +        }
> +
> +        if (i > 6) {
> +            linuxcpustat->has_irq =3D true;
> +            linuxcpustat->irq =3D irq * 1000 / clk_tck;
> +            linuxcpustat->has_softirq =3D true;
> +            linuxcpustat->softirq =3D softirq * 1000 / clk_tck;
> +        }
> +
> +        if (i > 8) {
> +            linuxcpustat->has_steal =3D true;
> +            linuxcpustat->steal =3D steal * 1000 / clk_tck;
> +        }
> +
> +        if (i > 9) {
> +            linuxcpustat->has_guest =3D true;
> +            linuxcpustat->guest =3D guest * 1000 / clk_tck;
> +        }
> +
> +        if (i > 10) {
> +            linuxcpustat->has_guest =3D true;
> +            linuxcpustat->guest =3D guest * 1000 / clk_tck;
> +            linuxcpustat->has_guestnice =3D true;
> +            linuxcpustat->guestnice =3D guest_nice * 1000 / clk_tck;
> +        }
> +
> +        QAPI_LIST_APPEND(tail, cpustat);
> +    }
> +
> +    free(line);
> +    fclose(fp);
> +    return head;
> +}
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 98aafc45f3..5da60e65ab 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1195,205 +1195,6 @@ GuestMemoryBlockInfo
> *qmp_guest_get_memory_block_info(Error **errp)
>      return info;
>  }
>
> -#define MAX_NAME_LEN 128
> -static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)
> -{
> -#ifdef CONFIG_LINUX
> -    GuestDiskStatsInfoList *head =3D NULL, **tail =3D &head;
> -    const char *diskstats =3D "/proc/diskstats";
> -    FILE *fp;
> -    size_t n;
> -    char *line =3D NULL;
> -
> -    fp =3D fopen(diskstats, "r");
> -    if (fp  =3D=3D NULL) {
> -        error_setg_errno(errp, errno, "open(\"%s\")", diskstats);
> -        return NULL;
> -    }
> -
> -    while (getline(&line, &n, fp) !=3D -1) {
> -        g_autofree GuestDiskStatsInfo *diskstatinfo =3D NULL;
> -        g_autofree GuestDiskStats *diskstat =3D NULL;
> -        char dev_name[MAX_NAME_LEN];
> -        unsigned int ios_pgr, tot_ticks, rq_ticks, wr_ticks, dc_ticks,
> fl_ticks;
> -        unsigned long rd_ios, rd_merges_or_rd_sec, rd_ticks_or_wr_sec,
> wr_ios;
> -        unsigned long wr_merges, rd_sec_or_wr_ios, wr_sec;
> -        unsigned long dc_ios, dc_merges, dc_sec, fl_ios;
> -        unsigned int major, minor;
> -        int i;
> -
> -        i =3D sscanf(line, "%u %u %s %lu %lu %lu"
> -                   "%lu %lu %lu %lu %u %u %u %u"
> -                   "%lu %lu %lu %u %lu %u",
> -                   &major, &minor, dev_name,
> -                   &rd_ios, &rd_merges_or_rd_sec, &rd_sec_or_wr_ios,
> -                   &rd_ticks_or_wr_sec, &wr_ios, &wr_merges, &wr_sec,
> -                   &wr_ticks, &ios_pgr, &tot_ticks, &rq_ticks,
> -                   &dc_ios, &dc_merges, &dc_sec, &dc_ticks,
> -                   &fl_ios, &fl_ticks);
> -
> -        if (i < 7) {
> -            continue;
> -        }
> -
> -        diskstatinfo =3D g_new0(GuestDiskStatsInfo, 1);
> -        diskstatinfo->name =3D g_strdup(dev_name);
> -        diskstatinfo->major =3D major;
> -        diskstatinfo->minor =3D minor;
> -
> -        diskstat =3D g_new0(GuestDiskStats, 1);
> -        if (i =3D=3D 7) {
> -            diskstat->has_read_ios =3D true;
> -            diskstat->read_ios =3D rd_ios;
> -            diskstat->has_read_sectors =3D true;
> -            diskstat->read_sectors =3D rd_merges_or_rd_sec;
> -            diskstat->has_write_ios =3D true;
> -            diskstat->write_ios =3D rd_sec_or_wr_ios;
> -            diskstat->has_write_sectors =3D true;
> -            diskstat->write_sectors =3D rd_ticks_or_wr_sec;
> -        }
> -        if (i >=3D 14) {
> -            diskstat->has_read_ios =3D true;
> -            diskstat->read_ios =3D rd_ios;
> -            diskstat->has_read_sectors =3D true;
> -            diskstat->read_sectors =3D rd_sec_or_wr_ios;
> -            diskstat->has_read_merges =3D true;
> -            diskstat->read_merges =3D rd_merges_or_rd_sec;
> -            diskstat->has_read_ticks =3D true;
> -            diskstat->read_ticks =3D rd_ticks_or_wr_sec;
> -            diskstat->has_write_ios =3D true;
> -            diskstat->write_ios =3D wr_ios;
> -            diskstat->has_write_sectors =3D true;
> -            diskstat->write_sectors =3D wr_sec;
> -            diskstat->has_write_merges =3D true;
> -            diskstat->write_merges =3D wr_merges;
> -            diskstat->has_write_ticks =3D true;
> -            diskstat->write_ticks =3D wr_ticks;
> -            diskstat->has_ios_pgr =3D true;
> -            diskstat->ios_pgr =3D ios_pgr;
> -            diskstat->has_total_ticks =3D true;
> -            diskstat->total_ticks =3D tot_ticks;
> -            diskstat->has_weight_ticks =3D true;
> -            diskstat->weight_ticks =3D rq_ticks;
> -        }
> -        if (i >=3D 18) {
> -            diskstat->has_discard_ios =3D true;
> -            diskstat->discard_ios =3D dc_ios;
> -            diskstat->has_discard_merges =3D true;
> -            diskstat->discard_merges =3D dc_merges;
> -            diskstat->has_discard_sectors =3D true;
> -            diskstat->discard_sectors =3D dc_sec;
> -            diskstat->has_discard_ticks =3D true;
> -            diskstat->discard_ticks =3D dc_ticks;
> -        }
> -        if (i >=3D 20) {
> -            diskstat->has_flush_ios =3D true;
> -            diskstat->flush_ios =3D fl_ios;
> -            diskstat->has_flush_ticks =3D true;
> -            diskstat->flush_ticks =3D fl_ticks;
> -        }
> -
> -        diskstatinfo->stats =3D g_steal_pointer(&diskstat);
> -        QAPI_LIST_APPEND(tail, diskstatinfo);
> -        diskstatinfo =3D NULL;
> -    }
> -    free(line);
> -    fclose(fp);
> -    return head;
> -#else
> -    g_debug("disk stats reporting available only for Linux");
> -    return NULL;
> -#endif
> -}
> -
> -GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
> -{
> -    return guest_get_diskstats(errp);
> -}
> -
> -GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
> -{
> -    GuestCpuStatsList *head =3D NULL, **tail =3D &head;
> -    const char *cpustats =3D "/proc/stat";
> -    int clk_tck =3D sysconf(_SC_CLK_TCK);
> -    FILE *fp;
> -    size_t n;
> -    char *line =3D NULL;
> -
> -    fp =3D fopen(cpustats, "r");
> -    if (fp  =3D=3D NULL) {
> -        error_setg_errno(errp, errno, "open(\"%s\")", cpustats);
> -        return NULL;
> -    }
> -
> -    while (getline(&line, &n, fp) !=3D -1) {
> -        GuestCpuStats *cpustat =3D NULL;
> -        GuestLinuxCpuStats *linuxcpustat;
> -        int i;
> -        unsigned long user, system, idle, iowait, irq, softirq, steal,
> guest;
> -        unsigned long nice, guest_nice;
> -        char name[64];
> -
> -        i =3D sscanf(line, "%s %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
> -                   name, &user, &nice, &system, &idle, &iowait, &irq,
> &softirq,
> -                   &steal, &guest, &guest_nice);
> -
> -        /* drop "cpu 1 2 3 ...", get "cpuX 1 2 3 ..." only */
> -        if ((i =3D=3D EOF) || strncmp(name, "cpu", 3) || (name[3] =3D=3D=
 '\0')) {
> -            continue;
> -        }
> -
> -        if (i < 5) {
> -            slog("Parsing cpu stat from %s failed, see \"man proc\"",
> cpustats);
> -            break;
> -        }
> -
> -        cpustat =3D g_new0(GuestCpuStats, 1);
> -        cpustat->type =3D GUEST_CPU_STATS_TYPE_LINUX;
> -
> -        linuxcpustat =3D &cpustat->u.q_linux;
> -        linuxcpustat->cpu =3D atoi(&name[3]);
> -        linuxcpustat->user =3D user * 1000 / clk_tck;
> -        linuxcpustat->nice =3D nice * 1000 / clk_tck;
> -        linuxcpustat->system =3D system * 1000 / clk_tck;
> -        linuxcpustat->idle =3D idle * 1000 / clk_tck;
> -
> -        if (i > 5) {
> -            linuxcpustat->has_iowait =3D true;
> -            linuxcpustat->iowait =3D iowait * 1000 / clk_tck;
> -        }
> -
> -        if (i > 6) {
> -            linuxcpustat->has_irq =3D true;
> -            linuxcpustat->irq =3D irq * 1000 / clk_tck;
> -            linuxcpustat->has_softirq =3D true;
> -            linuxcpustat->softirq =3D softirq * 1000 / clk_tck;
> -        }
> -
> -        if (i > 8) {
> -            linuxcpustat->has_steal =3D true;
> -            linuxcpustat->steal =3D steal * 1000 / clk_tck;
> -        }
> -
> -        if (i > 9) {
> -            linuxcpustat->has_guest =3D true;
> -            linuxcpustat->guest =3D guest * 1000 / clk_tck;
> -        }
> -
> -        if (i > 10) {
> -            linuxcpustat->has_guest =3D true;
> -            linuxcpustat->guest =3D guest * 1000 / clk_tck;
> -            linuxcpustat->has_guestnice =3D true;
> -            linuxcpustat->guestnice =3D guest_nice * 1000 / clk_tck;
> -        }
> -
> -        QAPI_LIST_APPEND(tail, cpustat);
> -    }
> -
> -    free(line);
> -    fclose(fp);
> -    return head;
> -}
>
>  #else /* defined(__linux__) */
>
> --
> 2.45.1
>
>

--0000000000007e04da061d08bbc5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:02=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">The qmp_guest_{diskstats,cpustats} command impls in<br>
commands-posix.c are surrounded by &#39;#ifdef __linux__&#39; so should<br>
instead live in commands-linux.c<br>
<br>
This also removes a &quot;#ifdef CONFIG_LINUX&quot; that was nested inside<=
br>
a &quot;#ifdef __linux__&quot;.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-linux.c | 195 ++++++++++++++++++++++++++++++++++++++++++=
<br>
=C2=A0qga/commands-posix.c | 199 ------------------------------------------=
-<br>
=C2=A02 files changed, 195 insertions(+), 199 deletions(-)<br>
<br>
diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
index 084e6c9e85..c0e8bd4062 100644<br>
--- a/qga/commands-linux.c<br>
+++ b/qga/commands-linux.c<br>
@@ -1594,3 +1594,198 @@ int64_t qmp_guest_set_vcpus(GuestLogicalProcessorLi=
st *vcpus, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return processed;<br>
=C2=A0}<br>
+<br>
+#define MAX_NAME_LEN 128<br>
+static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestDiskStatsInfoList *head =3D NULL, **tail =3D &amp;head;=
<br>
+=C2=A0 =C2=A0 const char *diskstats =3D &quot;/proc/diskstats&quot;;<br>
+=C2=A0 =C2=A0 FILE *fp;<br>
+=C2=A0 =C2=A0 size_t n;<br>
+=C2=A0 =C2=A0 char *line =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 fp =3D fopen(diskstats, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 if (fp=C2=A0 =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open(\&quo=
t;%s\&quot;)&quot;, diskstats);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 while (getline(&amp;line, &amp;n, fp) !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree GuestDiskStatsInfo *diskstatinfo =
=3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree GuestDiskStats *diskstat =3D NULL;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char dev_name[MAX_NAME_LEN];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int ios_pgr, tot_ticks, rq_ticks, wr_=
ticks, dc_ticks, fl_ticks;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long rd_ios, rd_merges_or_rd_sec, rd_=
ticks_or_wr_sec, wr_ios;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long wr_merges, rd_sec_or_wr_ios, wr_=
sec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long dc_ios, dc_merges, dc_sec, fl_io=
s;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int major, minor;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D sscanf(line, &quot;%u %u %s %lu %lu %lu&=
quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;%lu %lu %lu %lu %u %u %u %u&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;%lu %lu %lu %u %lu %u&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
major, &amp;minor, dev_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
rd_ios, &amp;rd_merges_or_rd_sec, &amp;rd_sec_or_wr_ios,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
rd_ticks_or_wr_sec, &amp;wr_ios, &amp;wr_merges, &amp;wr_sec,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
wr_ticks, &amp;ios_pgr, &amp;tot_ticks, &amp;rq_ticks,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
dc_ios, &amp;dc_merges, &amp;dc_sec, &amp;dc_ticks,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
fl_ios, &amp;fl_ticks);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &lt; 7) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo =3D g_new0(GuestDiskStatsInfo, 1)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo-&gt;name =3D g_strdup(dev_name);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo-&gt;major =3D major;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo-&gt;minor =3D minor;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat =3D g_new0(GuestDiskStats, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 7) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_ios =3D tr=
ue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_ios =3D rd_ios=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_sectors =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_sectors =3D rd=
_merges_or_rd_sec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_ios =3D t=
rue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_ios =3D rd_se=
c_or_wr_ios;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_sectors =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_sectors =3D r=
d_ticks_or_wr_sec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D 14) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_ios =3D tr=
ue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_ios =3D rd_ios=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_sectors =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_sectors =3D rd=
_sec_or_wr_ios;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_merges =3D=
 true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_merges =3D rd_=
merges_or_rd_sec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_ticks =3D =
true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_ticks =3D rd_t=
icks_or_wr_sec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_ios =3D t=
rue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_ios =3D wr_io=
s;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_sectors =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_sectors =3D w=
r_sec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_merges =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_merges =3D wr=
_merges;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_ticks =3D=
 true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_ticks =3D wr_=
ticks;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_ios_pgr =3D tru=
e;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;ios_pgr =3D ios_pgr=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_total_ticks =3D=
 true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;total_ticks =3D tot=
_ticks;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_weight_ticks =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;weight_ticks =3D rq=
_ticks;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D 18) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_discard_ios =3D=
 true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;discard_ios =3D dc_=
ios;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_discard_merges =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;discard_merges =3D =
dc_merges;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_discard_sectors=
 =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;discard_sectors =3D=
 dc_sec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_discard_ticks =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;discard_ticks =3D d=
c_ticks;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D 20) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_flush_ios =3D t=
rue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;flush_ios =3D fl_io=
s;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_flush_ticks =3D=
 true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;flush_ticks =3D fl_=
ticks;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo-&gt;stats =3D g_steal_pointer(&am=
p;diskstat);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, diskstatinfo);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 free(line);<br>
+=C2=A0 =C2=A0 fclose(fp);<br>
+=C2=A0 =C2=A0 return head;<br>
+}<br>
+<br>
+GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 return guest_get_diskstats(errp);<br>
+}<br>
+<br>
+GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestCpuStatsList *head =3D NULL, **tail =3D &amp;head;<br>
+=C2=A0 =C2=A0 const char *cpustats =3D &quot;/proc/stat&quot;;<br>
+=C2=A0 =C2=A0 int clk_tck =3D sysconf(_SC_CLK_TCK);<br>
+=C2=A0 =C2=A0 FILE *fp;<br>
+=C2=A0 =C2=A0 size_t n;<br>
+=C2=A0 =C2=A0 char *line =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 fp =3D fopen(cpustats, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 if (fp=C2=A0 =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open(\&quo=
t;%s\&quot;)&quot;, cpustats);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 while (getline(&amp;line, &amp;n, fp) !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestCpuStats *cpustat =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestLinuxCpuStats *linuxcpustat;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long user, system, idle, iowait, irq,=
 softirq, steal, guest;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long nice, guest_nice;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char name[64];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D sscanf(line, &quot;%s %lu %lu %lu %lu %l=
u %lu %lu %lu %lu %lu&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name,=
 &amp;user, &amp;nice, &amp;system, &amp;idle, &amp;iowait, &amp;irq, &amp;=
softirq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
steal, &amp;guest, &amp;guest_nice);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* drop &quot;cpu 1 2 3 ...&quot;, get &quot;c=
puX 1 2 3 ...&quot; only */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i =3D=3D EOF) || strncmp(name, &quot;cpu&=
quot;, 3) || (name[3] =3D=3D &#39;\0&#39;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &lt; 5) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;Parsing cpu stat from=
 %s failed, see \&quot;man proc\&quot;&quot;, cpustats);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpustat =3D g_new0(GuestCpuStats, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpustat-&gt;type =3D GUEST_CPU_STATS_TYPE_LINU=
X;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat =3D &amp;cpustat-&gt;u.q_linux;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;cpu =3D atoi(&amp;name[3]);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;user =3D user * 1000 / clk_tc=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;nice =3D nice * 1000 / clk_tc=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;system =3D system * 1000 / cl=
k_tck;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;idle =3D idle * 1000 / clk_tc=
k;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt; 5) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_iowait =3D =
true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;iowait =3D iowa=
it * 1000 / clk_tck;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt; 6) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_irq =3D tru=
e;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;irq =3D irq * 1=
000 / clk_tck;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_softirq =3D=
 true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;softirq =3D sof=
tirq * 1000 / clk_tck;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt; 8) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_steal =3D t=
rue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;steal =3D steal=
 * 1000 / clk_tck;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt; 9) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_guest =3D t=
rue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;guest =3D guest=
 * 1000 / clk_tck;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt; 10) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_guest =3D t=
rue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;guest =3D guest=
 * 1000 / clk_tck;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_guestnice =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;guestnice =3D g=
uest_nice * 1000 / clk_tck;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, cpustat);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 free(line);<br>
+=C2=A0 =C2=A0 fclose(fp);<br>
+=C2=A0 =C2=A0 return head;<br>
+}<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 98aafc45f3..5da60e65ab 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1195,205 +1195,6 @@ GuestMemoryBlockInfo *qmp_guest_get_memory_block_in=
fo(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0return info;<br>
=C2=A0}<br>
<br>
-#define MAX_NAME_LEN 128<br>
-static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)<br>
-{<br>
-#ifdef CONFIG_LINUX<br>
-=C2=A0 =C2=A0 GuestDiskStatsInfoList *head =3D NULL, **tail =3D &amp;head;=
<br>
-=C2=A0 =C2=A0 const char *diskstats =3D &quot;/proc/diskstats&quot;;<br>
-=C2=A0 =C2=A0 FILE *fp;<br>
-=C2=A0 =C2=A0 size_t n;<br>
-=C2=A0 =C2=A0 char *line =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 fp =3D fopen(diskstats, &quot;r&quot;);<br>
-=C2=A0 =C2=A0 if (fp=C2=A0 =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open(\&quo=
t;%s\&quot;)&quot;, diskstats);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 while (getline(&amp;line, &amp;n, fp) !=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree GuestDiskStatsInfo *diskstatinfo =
=3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree GuestDiskStats *diskstat =3D NULL;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char dev_name[MAX_NAME_LEN];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int ios_pgr, tot_ticks, rq_ticks, wr_=
ticks, dc_ticks, fl_ticks;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long rd_ios, rd_merges_or_rd_sec, rd_=
ticks_or_wr_sec, wr_ios;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long wr_merges, rd_sec_or_wr_ios, wr_=
sec;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long dc_ios, dc_merges, dc_sec, fl_io=
s;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int major, minor;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D sscanf(line, &quot;%u %u %s %lu %lu %lu&=
quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;%lu %lu %lu %lu %u %u %u %u&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;%lu %lu %lu %u %lu %u&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
major, &amp;minor, dev_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
rd_ios, &amp;rd_merges_or_rd_sec, &amp;rd_sec_or_wr_ios,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
rd_ticks_or_wr_sec, &amp;wr_ios, &amp;wr_merges, &amp;wr_sec,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
wr_ticks, &amp;ios_pgr, &amp;tot_ticks, &amp;rq_ticks,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
dc_ios, &amp;dc_merges, &amp;dc_sec, &amp;dc_ticks,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
fl_ios, &amp;fl_ticks);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &lt; 7) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo =3D g_new0(GuestDiskStatsInfo, 1)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo-&gt;name =3D g_strdup(dev_name);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo-&gt;major =3D major;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo-&gt;minor =3D minor;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat =3D g_new0(GuestDiskStats, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 7) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_ios =3D tr=
ue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_ios =3D rd_ios=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_sectors =
=3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_sectors =3D rd=
_merges_or_rd_sec;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_ios =3D t=
rue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_ios =3D rd_se=
c_or_wr_ios;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_sectors =
=3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_sectors =3D r=
d_ticks_or_wr_sec;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D 14) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_ios =3D tr=
ue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_ios =3D rd_ios=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_sectors =
=3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_sectors =3D rd=
_sec_or_wr_ios;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_merges =3D=
 true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_merges =3D rd_=
merges_or_rd_sec;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_read_ticks =3D =
true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;read_ticks =3D rd_t=
icks_or_wr_sec;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_ios =3D t=
rue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_ios =3D wr_io=
s;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_sectors =
=3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_sectors =3D w=
r_sec;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_merges =
=3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_merges =3D wr=
_merges;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_write_ticks =3D=
 true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;write_ticks =3D wr_=
ticks;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_ios_pgr =3D tru=
e;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;ios_pgr =3D ios_pgr=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_total_ticks =3D=
 true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;total_ticks =3D tot=
_ticks;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_weight_ticks =
=3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;weight_ticks =3D rq=
_ticks;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D 18) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_discard_ios =3D=
 true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;discard_ios =3D dc_=
ios;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_discard_merges =
=3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;discard_merges =3D =
dc_merges;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_discard_sectors=
 =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;discard_sectors =3D=
 dc_sec;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_discard_ticks =
=3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;discard_ticks =3D d=
c_ticks;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D 20) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_flush_ios =3D t=
rue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;flush_ios =3D fl_io=
s;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;has_flush_ticks =3D=
 true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;flush_ticks =3D fl_=
ticks;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo-&gt;stats =3D g_steal_pointer(&am=
p;diskstat);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, diskstatinfo);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstatinfo =3D NULL;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 free(line);<br>
-=C2=A0 =C2=A0 fclose(fp);<br>
-=C2=A0 =C2=A0 return head;<br>
-#else<br>
-=C2=A0 =C2=A0 g_debug(&quot;disk stats reporting available only for Linux&=
quot;);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-#endif<br>
-}<br>
-<br>
-GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 return guest_get_diskstats(errp);<br>
-}<br>
-<br>
-GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 GuestCpuStatsList *head =3D NULL, **tail =3D &amp;head;<br>
-=C2=A0 =C2=A0 const char *cpustats =3D &quot;/proc/stat&quot;;<br>
-=C2=A0 =C2=A0 int clk_tck =3D sysconf(_SC_CLK_TCK);<br>
-=C2=A0 =C2=A0 FILE *fp;<br>
-=C2=A0 =C2=A0 size_t n;<br>
-=C2=A0 =C2=A0 char *line =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 fp =3D fopen(cpustats, &quot;r&quot;);<br>
-=C2=A0 =C2=A0 if (fp=C2=A0 =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open(\&quo=
t;%s\&quot;)&quot;, cpustats);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 while (getline(&amp;line, &amp;n, fp) !=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestCpuStats *cpustat =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestLinuxCpuStats *linuxcpustat;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long user, system, idle, iowait, irq,=
 softirq, steal, guest;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long nice, guest_nice;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char name[64];<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D sscanf(line, &quot;%s %lu %lu %lu %lu %l=
u %lu %lu %lu %lu %lu&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name,=
 &amp;user, &amp;nice, &amp;system, &amp;idle, &amp;iowait, &amp;irq, &amp;=
softirq,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
steal, &amp;guest, &amp;guest_nice);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* drop &quot;cpu 1 2 3 ...&quot;, get &quot;c=
puX 1 2 3 ...&quot; only */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i =3D=3D EOF) || strncmp(name, &quot;cpu&=
quot;, 3) || (name[3] =3D=3D &#39;\0&#39;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &lt; 5) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;Parsing cpu stat from=
 %s failed, see \&quot;man proc\&quot;&quot;, cpustats);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpustat =3D g_new0(GuestCpuStats, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpustat-&gt;type =3D GUEST_CPU_STATS_TYPE_LINU=
X;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat =3D &amp;cpustat-&gt;u.q_linux;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;cpu =3D atoi(&amp;name[3]);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;user =3D user * 1000 / clk_tc=
k;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;nice =3D nice * 1000 / clk_tc=
k;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;system =3D system * 1000 / cl=
k_tck;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;idle =3D idle * 1000 / clk_tc=
k;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt; 5) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_iowait =3D =
true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;iowait =3D iowa=
it * 1000 / clk_tck;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt; 6) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_irq =3D tru=
e;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;irq =3D irq * 1=
000 / clk_tck;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_softirq =3D=
 true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;softirq =3D sof=
tirq * 1000 / clk_tck;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt; 8) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_steal =3D t=
rue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;steal =3D steal=
 * 1000 / clk_tck;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt; 9) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_guest =3D t=
rue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;guest =3D guest=
 * 1000 / clk_tck;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt; 10) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_guest =3D t=
rue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;guest =3D guest=
 * 1000 / clk_tck;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;has_guestnice =
=3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linuxcpustat-&gt;guestnice =3D g=
uest_nice * 1000 / clk_tck;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, cpustat);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 free(line);<br>
-=C2=A0 =C2=A0 fclose(fp);<br>
-=C2=A0 =C2=A0 return head;<br>
-}<br>
<br>
=C2=A0#else /* defined(__linux__) */<br>
<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--0000000000007e04da061d08bbc5--


