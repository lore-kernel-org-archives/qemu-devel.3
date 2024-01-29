Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636F3C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 18:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUWl0-0003aq-Ch; Mon, 29 Jan 2024 13:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUWky-0003aa-Nt
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:53:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUWkv-0005wY-Nm
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706554395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tszMTcD3Q3ztgpOxQ5N1MYQGpW7Y0w7Ln0SRHAUugNU=;
 b=O9baUssIc/Na/Yok9FGcM9jJNnnKBfXDkBxYyhQpmwG5UTC7veNUBqPDrTTmINlsP3eb0B
 2LUNZ9I3RKMNSYkBbSJPegQd2E8/CDS/wsBul2vWrBSz66wDZAplDxUePa1+enbyqRkeyu
 qD5XMqFL72YzdThxjtO9mQS0Y7tb1bo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-Tuzn17jSM6KHiMocrmYPaQ-1; Mon,
 29 Jan 2024 13:53:13 -0500
X-MC-Unique: Tuzn17jSM6KHiMocrmYPaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D4103816B45
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 18:53:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75C631C060B2;
 Mon, 29 Jan 2024 18:53:12 +0000 (UTC)
Date: Mon, 29 Jan 2024 18:53:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com
Subject: Re: [PATCH v3 2/3] tools: build qemu-vmsr-helper
Message-ID: <Zbf0Fbhmg0tvMbxK@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-3-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125072214.318382-3-aharivel@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 25, 2024 at 08:22:13AM +0100, Anthony Harivel wrote:
> Introduce a privileged helper to access RAPL MSR.
> 
> The privileged helper tool, qemu-vmsr-helper, is designed to provide
> virtual machines with the ability to read specific RAPL (Running Average
> Power Limit) MSRs without requiring CAP_SYS_RAWIO privileges or relying
> on external, out-of-tree patches.
> 
> The helper tool leverages Unix permissions and SO_PEERCRED socket
> options to enforce access control, ensuring that only processes
> explicitly requesting read access via readmsr() from a valid Thread ID
> can access these MSRs.
> 
> The list of RAPL MSRs that are allowed to be read by the helper tool is
> defined in rapl-msr-index.h. This list corresponds to the RAPL MSRs that
> will be supported in the next commit titled "Add support for RAPL MSRs
> in KVM/QEMU."
> 
> The tool is intentionally designed to run on the Linux x86 platform.
> This initial implementation is tailored for Intel CPUs but can be
> extended to support AMD CPUs in the future.
> 
> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> ---
>  contrib/systemd/qemu-vmsr-helper.service |  15 +
>  contrib/systemd/qemu-vmsr-helper.socket  |   9 +
>  docs/tools/index.rst                     |   1 +
>  docs/tools/qemu-vmsr-helper.rst          |  89 ++++
>  meson.build                              |   5 +
>  tools/i386/qemu-vmsr-helper.c            | 507 +++++++++++++++++++++++
>  tools/i386/rapl-msr-index.h              |  28 ++
>  7 files changed, 654 insertions(+)
>  create mode 100644 contrib/systemd/qemu-vmsr-helper.service
>  create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
>  create mode 100644 docs/tools/qemu-vmsr-helper.rst
>  create mode 100644 tools/i386/qemu-vmsr-helper.c
>  create mode 100644 tools/i386/rapl-msr-index.h
> 
> diff --git a/contrib/systemd/qemu-vmsr-helper.service b/contrib/systemd/qemu-vmsr-helper.service
> new file mode 100644
> index 000000000000..8fd397bf79a9
> --- /dev/null
> +++ b/contrib/systemd/qemu-vmsr-helper.service
> @@ -0,0 +1,15 @@
> +[Unit]
> +Description=Virtual RAPL MSR Daemon for QEMU
> +
> +[Service]
> +WorkingDirectory=/tmp
> +Type=simple
> +ExecStart=/usr/bin/qemu-vmsr-helper
> +PrivateTmp=yes
> +ProtectSystem=strict
> +ReadWritePaths=/var/run
> +RestrictAddressFamilies=AF_UNIX
> +Restart=always
> +RestartSec=0
> +
> +[Install]
> diff --git a/contrib/systemd/qemu-vmsr-helper.socket b/contrib/systemd/qemu-vmsr-helper.socket
> new file mode 100644
> index 000000000000..183e8304d6e2
> --- /dev/null
> +++ b/contrib/systemd/qemu-vmsr-helper.socket
> @@ -0,0 +1,9 @@
> +[Unit]
> +Description=Virtual RAPL MSR helper for QEMU
> +
> +[Socket]
> +ListenStream=/run/qemu-vmsr-helper.sock
> +SocketMode=0600

This mode means that only root can connect to it, which seems to
defeat the purpose of allowing QEMU to run as non-root surely ?


> diff --git a/meson.build b/meson.build
> index d0329966f1b4..93fc233b0891 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4015,6 +4015,11 @@ if have_tools
>                 dependencies: [authz, crypto, io, qom, qemuutil,
>                                libcap_ng, mpathpersist],
>                 install: true)
> +
> +    executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.c'),

I'd suggest 'tools/x86/' since this works fine on 64-bit too

> +               dependencies: [authz, crypto, io, qom, qemuutil,
> +                              libcap_ng, mpathpersist],
> +               install: true)

Shouldn't this executable() call be conditional though, so this
is only built for x86 host targets.

>    endif
>  
>    if have_ivshmem

> diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
> new file mode 100644
> index 000000000000..cf7d09bfcab3
> --- /dev/null
> +++ b/tools/i386/qemu-vmsr-helper.c

> +
> +#define MAX_PATH_LEN 256

Drop this constant as it is redundant

> +#define MSR_PATH_TEMPLATE "/dev/cpu/%u/msr"
> +
> +static char *socket_path;
> +static char *pidfile;
> +static enum { RUNNING, TERMINATE, TERMINATING } state;
> +static QIOChannelSocket *server_ioc;
> +static int server_watch;
> +static int num_active_sockets = 1;
> +
> +#ifdef CONFIG_LIBCAP_NG
> +static int uid = -1;
> +static int gid = -1;
> +#endif
> +
> +static void compute_default_paths(void)
> +{
> +    socket_path = g_build_filename("/run", "qemu-vmsr-helper.sock", NULL);
> +    pidfile = g_build_filename("/run", "qemu-vmsr-helper.pid", NULL);
> +}

We shouldn't be hardcoding /run, we need to honour --prefix and
--localstatedir args given to configure.  /var/run is a symlink
to /run so the end result ends up the same AFAIK

> +
> +/*
> + * Check if the TID that request the MSR read
> + * belongs to the peer. It be should a TID of a vCPU.
> + */
> +static bool is_tid_present(pid_t pid, pid_t tid)
> +{
> +    g_autofree char *pidStr;
> +    g_autofree char *tidStr;
> +
> +    pidStr = g_strdup_printf("%d", pid);
> +    tidStr = g_strdup_printf("%d", tid);
> +
> +    char *tidPath;

This needs to be g_autofree too, and as a rule any variable
declared with 'g_autofree' should always be initialized at
the same time as declaration, so put the g_strdup_printf
calls on the same line.

> +
> +    tidPath = g_strdup_printf("/proc/%s/task/%s", pidStr, tidStr);

> +
> +    /* Check if the TID directory exists within the PID directory */
> +    if (access(tidPath, F_OK) == 0) {
> +        return true;
> +    }
> +    error_report("Failed to open /proc at %s", tidPath);
> +    return false;
> +}
> +
> +/*
> + * Only the RAPL MSR in target/i386/cpu.h are allowed
> + */
> +static bool is_msr_allowed(uint32_t reg)
> +{
> +    switch (reg) {
> +    case MSR_RAPL_POWER_UNIT:
> +    case MSR_PKG_POWER_LIMIT:
> +    case MSR_PKG_ENERGY_STATUS:
> +    case MSR_PKG_POWER_INFO:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +static uint64_t vmsr_read_msr(uint32_t msr_register, unsigned int cpu_id)
> +{
> +    int fd;
> +    uint64_t result = 0;
> +
> +    g_autofree char *path;
> +    path = g_new0(char, MAX_PATH_LEN);

This is a memory leak as it is overwritten on the next line.

> +    path = g_strdup_printf(MSR_PATH_TEMPLATE, cpu_id);

Since this constant is only used in one place, I'd prefer to see it
inline here, so an observer can see what format specifiers are relied
upon

> +
> +    /*
> +     * Check if the specified CPU is included in the thread's affinity
> +     */
> +    cpu_set_t cpu_set;
> +    CPU_ZERO(&cpu_set);
> +    sched_getaffinity(0, sizeof(cpu_set_t), &cpu_set);


Using cpu_set_t will break on machines with >= 1024 CPUs.

There are a numbr of painpoints with calling sched_getaffinity so
rather than try to explain them, let me point you to the man page
for sched_getaffinity underthe headeing:

  "Handling systems with large CPU affinity masks"


> +
> +    if (!CPU_ISSET(cpu_id, &cpu_set)) {
> +        fprintf(stderr, "CPU %u is not in the thread's affinity.\n", cpu_id);

Use error_report() for consistency

> +        return result;
> +    }
> +
> +    fd = open(path, O_RDONLY);
> +    if (fd < 0) {
> +        error_report("Failed to open MSR file at %s", path);
> +        return result;
> +    }
> +
> +    if (pread(fd, &result, sizeof(result), msr_register) != sizeof(result)) {

Leaks 'fd'

> +        error_report("Failed to read MSR");
> +        result = 0;
> +    }
> +
> +    close(fd);
> +    return result;
> +}


> +static void coroutine_fn vh_co_entry(void *opaque)
> +{
> +    VMSRHelperClient *client = opaque;
> +    uint64_t vmsr;
> +    uint32_t request[3];
> +    unsigned int peer_pid;
> +    int r;
> +    Error *local_err = NULL;
> +
> +    qio_channel_set_blocking(QIO_CHANNEL(client->ioc),
> +                             false, NULL);
> +
> +    qio_channel_set_follow_coroutine_ctx(QIO_CHANNEL(client->ioc), true);
> +
> +    /*
> +     * Check peer credentials
> +     */
> +    qio_channel_get_peerpid(QIO_CHANNEL(client->ioc), &peer_pid, &local_err);
> +
> +    if (peer_pid == 0) {
> +        if (local_err != NULL) {
> +            error_report_err(local_err);
> +        }
> +        error_report("Failed to get peer credentials");

Using peer_pid == 0 as a substitute for checking if 'local_err' is set
is bogus. Check for 'local_err != NULL'.

> +        goto out;
> +    }
> +
> +    /*
> +     * Read the requested MSR
> +     * Only RAPL MSR in rapl-msr-index.h is allowed
> +     */
> +    r = qio_channel_read_all(QIO_CHANNEL(client->ioc),
> +                             (char *) &request, sizeof(request), &local_err);
> +    if ((local_err != NULL) || r < 0) {

Checking both conditions is redundant, pick one

> +        error_report("Read request fail");
> +        error_report_err(local_err);
> +        goto out;
> +    }
> +    if (!is_msr_allowed(request[0])) {
> +        error_report("Requested unallowed msr: %d", request[0]);
> +        goto out;
> +    }
> +
> +    vmsr = vmsr_read_msr(request[0], request[1]);
> +
> +    if (!is_tid_present(peer_pid, request[2])) {
> +        error_report("Requested TID not in peer PID: %d %d",
> +            peer_pid, request[2]);

Indent is a little off.

You never answered my question from the previous posting of this

This check is merely validating the the thread ID in the message
is a child of the process ID connected to the socket. Any process
on the entire host can satisfy this requirement.

I don't see what is limiting this to only QEMU as claimed by the
commit message, unless you're expecting the UNIX socket permissions
to be such that only processes under the qemu:qemu user:group pair
can access to the socket ? That would be a libvirt based permissions
assumption though.

> +        vmsr = 0;
> +    }
> +
> +    r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
> +                         (char *) &vmsr, sizeof(vmsr), &local_err);

Indent got a little off here too.

> +    if ((local_err != NULL) || r < 0) {

Again redundant checks

> +        error_report("Write request fail");
> +        error_report_err(local_err);
> +        goto out;
> +    }
> +
> +out:
> +    object_unref(OBJECT(client->ioc));
> +    g_free(client);
> +}
> +
> +static gboolean accept_client(QIOChannel *ioc,
> +                              GIOCondition cond,
> +                              gpointer opaque)
> +{
> +    QIOChannelSocket *cioc;
> +    VMSRHelperClient *vmsrh;
> +
> +    cioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
> +                                     NULL);
> +    if (!cioc) {
> +        return TRUE;
> +    }
> +
> +    vmsrh = g_new(VMSRHelperClient, 1);
> +    vmsrh->ioc = cioc;
> +    vmsrh->co = qemu_coroutine_create(vh_co_entry, vmsrh);
> +    qemu_coroutine_enter(vmsrh->co);
> +
> +    return TRUE;
> +}
> +
> +static void termsig_handler(int signum)
> +{
> +    qatomic_cmpxchg(&state, RUNNING, TERMINATE);
> +    qemu_notify_event();
> +}
> +
> +static void close_server_socket(void)
> +{
> +    assert(server_ioc);
> +
> +    g_source_remove(server_watch);
> +    server_watch = -1;
> +    object_unref(OBJECT(server_ioc));
> +    num_active_sockets--;
> +}
> +
> +#ifdef CONFIG_LIBCAP_NG
> +static int drop_privileges(void)
> +{
> +    /* clear all capabilities */
> +    capng_clear(CAPNG_SELECT_BOTH);
> +
> +    if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
> +                     CAP_SYS_RAWIO) < 0) {
> +        return -1;
> +    }
> +
> +    /*
> +     * Change user/group id, retaining the capabilities.
> +     * Because file descriptors are passed via SCM_RIGHTS,
> +     * we don't need supplementary groups (and in fact the helper
> +     * can run as "nobody").
> +     */
> +    if (capng_change_id(uid != -1 ? uid : getuid(),
> +                        gid != -1 ? gid : getgid(),
> +                        CAPNG_DROP_SUPP_GRP | CAPNG_CLEAR_BOUNDING)) {
> +        return -1;
> +    }

Does this actually work ?  IIUC, the file that requires privileges
is /dev/cpu/%u/msr, and we're opening that fresh on every request,
so how can this run as anything other than root ?

> +
> +    return 0;
> +}
> +#endif
> +
> +int main(int argc, char **argv)
> +{
> +    const char *sopt = "hVk:f:dT:u:g:vq";
> +    struct option lopt[] = {
> +        { "help", no_argument, NULL, 'h' },
> +        { "version", no_argument, NULL, 'V' },
> +        { "socket", required_argument, NULL, 'k' },
> +        { "pidfile", required_argument, NULL, 'f' },
> +        { "daemon", no_argument, NULL, 'd' },
> +        { "trace", required_argument, NULL, 'T' },
> +        { "user", required_argument, NULL, 'u' },
> +        { "group", required_argument, NULL, 'g' },
> +        { "verbose", no_argument, NULL, 'v' },
> +        { NULL, 0, NULL, 0 }
> +    };
> +    int opt_ind = 0;
> +    int ch;
> +    Error *local_err = NULL;
> +    bool daemonize = false;
> +    bool pidfile_specified = false;
> +    bool socket_path_specified = false;
> +    unsigned socket_activation;
> +
> +    struct sigaction sa_sigterm;
> +    memset(&sa_sigterm, 0, sizeof(sa_sigterm));
> +    sa_sigterm.sa_handler = termsig_handler;
> +    sigaction(SIGTERM, &sa_sigterm, NULL);
> +    sigaction(SIGINT, &sa_sigterm, NULL);
> +    sigaction(SIGHUP, &sa_sigterm, NULL);
> +
> +    signal(SIGPIPE, SIG_IGN);
> +
> +    error_init(argv[0]);
> +    module_call_init(MODULE_INIT_TRACE);
> +    module_call_init(MODULE_INIT_QOM);
> +    qemu_add_opts(&qemu_trace_opts);
> +    qemu_init_exec_dir(argv[0]);
> +
> +    compute_default_paths();
> +
> +    while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
> +        switch (ch) {
> +        case 'k':
> +            g_free(socket_path);
> +            socket_path = g_strdup(optarg);
> +            socket_path_specified = true;
> +            if (socket_path[0] != '/') {
> +                error_report("socket path must be absolute");
> +                exit(EXIT_FAILURE);
> +            }
> +            break;
> +        case 'f':
> +            g_free(pidfile);
> +            pidfile = g_strdup(optarg);
> +            pidfile_specified = true;
> +            break;
> +#ifdef CONFIG_LIBCAP_NG
> +        case 'u': {
> +            unsigned long res;
> +            struct passwd *userinfo = getpwnam(optarg);
> +            if (userinfo) {
> +                uid = userinfo->pw_uid;
> +            } else if (qemu_strtoul(optarg, NULL, 10, &res) == 0 &&
> +                       (uid_t)res == res) {
> +                uid = res;
> +            } else {
> +                error_report("invalid user '%s'", optarg);
> +                exit(EXIT_FAILURE);
> +            }
> +            break;
> +        }
> +        case 'g': {
> +            unsigned long res;
> +            struct group *groupinfo = getgrnam(optarg);
> +            if (groupinfo) {
> +                gid = groupinfo->gr_gid;
> +            } else if (qemu_strtoul(optarg, NULL, 10, &res) == 0 &&
> +                       (gid_t)res == res) {
> +                gid = res;
> +            } else {
> +                error_report("invalid group '%s'", optarg);
> +                exit(EXIT_FAILURE);
> +            }
> +            break;
> +        }
> +#else
> +        case 'u':
> +        case 'g':
> +            error_report("-%c not supported by this %s", ch, argv[0]);
> +            exit(1);
> +#endif
> +        case 'd':
> +            daemonize = true;
> +            break;
> +        case 'T':
> +            trace_opt_parse(optarg);
> +            break;
> +        case 'V':
> +            version(argv[0]);
> +            exit(EXIT_SUCCESS);
> +            break;
> +        case 'h':
> +            usage(argv[0]);
> +            exit(EXIT_SUCCESS);
> +            break;
> +        case '?':
> +            error_report("Try `%s --help' for more information.", argv[0]);
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    if (!trace_init_backends()) {
> +        exit(EXIT_FAILURE);
> +    }
> +    trace_init_file();
> +    qemu_set_log(LOG_TRACE, &error_fatal);
> +
> +    socket_activation = check_socket_activation();
> +    if (socket_activation == 0) {
> +        SocketAddress saddr;
> +        saddr = (SocketAddress){
> +            .type = SOCKET_ADDRESS_TYPE_UNIX,
> +            .u.q_unix.path = socket_path,
> +        };
> +        server_ioc = qio_channel_socket_new();
> +        if (qio_channel_socket_listen_sync(server_ioc, &saddr,
> +                                           1, &local_err) < 0) {
> +            object_unref(OBJECT(server_ioc));
> +            error_report_err(local_err);
> +            return 1;
> +        }
> +    } else {
> +        /* Using socket activation - check user didn't use -p etc. */
> +        if (socket_path_specified) {
> +            error_report("Unix socket can't be set when \
> +                        using socket activation");
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        /* Can only listen on a single socket.  */
> +        if (socket_activation > 1) {
> +            error_report("%s does not support socket activation \
> +                        with LISTEN_FDS > 1",
> +                        argv[0]);
> +            exit(EXIT_FAILURE);
> +        }
> +        server_ioc = qio_channel_socket_new_fd(FIRST_SOCKET_ACTIVATION_FD,
> +                                               &local_err);
> +        if (server_ioc == NULL) {
> +            error_reportf_err(local_err,
> +                              "Failed to use socket activation: ");
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    qemu_init_main_loop(&error_fatal);
> +
> +    server_watch = qio_channel_add_watch(QIO_CHANNEL(server_ioc),
> +                                         G_IO_IN,
> +                                         accept_client,
> +                                         NULL, NULL);
> +
> +    if (daemonize) {
> +        if (daemon(0, 0) < 0) {
> +            error_report("Failed to daemonize: %s", strerror(errno));
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    if (daemonize || pidfile_specified) {
> +        qemu_write_pidfile(pidfile, &error_fatal);
> +    }
> +
> +#ifdef CONFIG_LIBCAP_NG
> +    if (drop_privileges() < 0) {
> +        error_report("Failed to drop privileges: %s", strerror(errno));
> +        exit(EXIT_FAILURE);
> +    }
> +#endif
> +
> +    state = RUNNING;
> +    do {
> +        main_loop_wait(false);
> +        if (state == TERMINATE) {
> +            state = TERMINATING;
> +            close_server_socket();
> +        }
> +    } while (num_active_sockets > 0);
> +
> +    exit(EXIT_SUCCESS);
> +}
> diff --git a/tools/i386/rapl-msr-index.h b/tools/i386/rapl-msr-index.h
> new file mode 100644
> index 000000000000..9a7118639ae3
> --- /dev/null
> +++ b/tools/i386/rapl-msr-index.h
> @@ -0,0 +1,28 @@
> +/*
> + * Allowed list of MSR for Privileged RAPL MSR helper commands for QEMU
> + *
> + * Copyright (C) 2023 Red Hat, Inc. <aharivel@redhat.com>
> + *
> + * Author: Anthony Harivel <aharivel@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; under version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * Should stay in sync with the RAPL MSR
> + * in target/i386/cpu.h
> + */
> +#define MSR_RAPL_POWER_UNIT             0x00000606
> +#define MSR_PKG_POWER_LIMIT             0x00000610
> +#define MSR_PKG_ENERGY_STATUS           0x00000611
> +#define MSR_PKG_POWER_INFO              0x00000614
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


