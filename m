Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E4606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=AI7Aumrj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1md-0007d5-HJ; Thu, 05 Nov 2026 13:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1mc-0007co-Af
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:01:54 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1ma-0003Sk-Et
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:01:54 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1238999f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 10:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793901710; x=1794506510; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1YH6OZ60KM2ymPWle9t+W1ZCAX5Bo2S6c1+/BxGzSGA=;
 b=AI7AumrjdqObncEWVLiIIa+XybcGtND1XNzW8VL4gYj0JYnqFjB4euBsBdzw066mVn
 L2pGO1Yci0+XjoZoi+1g/sjpThWp9jLf2toch+IVvWUtBDLR0uuoDTk6L1YkDGmVLSO0
 g95iR5kBmC/sc0CpIWzPRa1NljpHhzf0oqul1ZtG2283HzDXHzDDM8TwdBVYv09tYN9H
 GdSIqUk/DRUevgjKOLBMJDGrJqmKTrnVI6hEqIc13Ny91zifdyhd/dXZG9qYL+XEvK3U
 wxsRLRh1TEcmLFuPKiraOvyQz92KHMu+NOJBV/2Ecag7eQA4VAxhOMKWA5Dw3ErKvZ4d
 xXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793901710; x=1794506510;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1YH6OZ60KM2ymPWle9t+W1ZCAX5Bo2S6c1+/BxGzSGA=;
 b=twDkWQrTQYX5elRWOHTnL1Dx1Sh57yfCIXzzp9LZqIAXU/nKqKa9H28jSGGsWP87DS
 bSBGkibWrhz2Aur0Xhzk1TGMUydsp4uQ54KStmCA2a7LshgXBgugWXFg6BoDIGtXfh/O
 Hl5KL0whb1HTPdsQIoaSx7pZ95EtnN5+1D2S9osSc83k5P18DLqYMgX4mgdFpcb5cNXm
 8nT7Z5Z1yu/Vry/oQRVxTxekhRvdUdzybLk59Pg6gjciLSN8f0nznD+pfAUYE6JiDWKC
 0uWQgsrUykk7HfCsfNvVgE0YfI72az2joJ+eJgICnR6xp7ZQBwHXphno+UF6sWwDigV6
 0iIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzICbuWx++JMrBjxbEIwSlDtl3GfzV+bnQ8coqdX0kv8cQRp2edwI0Z9LyY7/pEGicrGkO686dkHbKk@nongnu.org
X-Gm-Message-State: APuU4Z+uZqae/moFDhmZAm5ldSGujFax/f5kuWr9cM2nzDsuXtoeOJez
 LAtx/OKwtCbsWC8GiQQfwXkKnQODqY5tvfi4SrXMcIKf6TGKjC5CuTEPsJvLWiPc3T4=
X-Gm-Gg: AYBFou0i/8Btx5FbFcGwiKRJUX8vrrpvKCaAtxEffVZLEAGZXSlCRG/jlxXhdOyUVLs
 7h0vi28302tCPI8GoOPBhQSXyi8VQhat/+1BSjecH5qKcq/CeeQHCF3/8JcT5FQlOvK2f6zAdAa
 XkLUDy97mLC34Hkf7IVQzBrBGH8SooANQJP5b9MF1WkE5kj326Ax6hQ+rPBo1FpDYKSJP0Y7qJd
 JaZ1ABi6f2V7j2kuVy5UAfr3dAO+hJIcMJShF0272vb8KIDmo6UDSuIg5NuF927y7AmiFkvtx74
 PVI9O1/HBI2fdzaHZY6jnjGV/SvBMeUC4JUQFsS0N1tiuoO20VlDBN/I4Oi+lSkYBDkjlij12as
 NR0UQm9qQjWhL/qeGDjy5dlI3LPTDh4NS/RK4I0qKR2ZbzuBFNFL7C90UeG9ptjnGgZpzjEoCXh
 QoAOC9t3bmR68HUSawg+7c1IgpWh+NVJ1oLA5HTNj6yVC/kv9ysp/vcEF9JwtFMcdCWmmBa9/Oh
 EQzb18AMhOeD0It7pT8x3Crdw2mqfpc8j/mUOc+3+NNrKVpEzr952PEolzGCnrqOcSuKRyQm48M
 0n/nPYMmOeNiAufjBWXNH6w8LirRM8OuIlKb57JMJhIMBKY=
X-Received: by 2002:a05:6000:25ea:b0:491:36b3:22c with SMTP id
 ffacd0b85a97d-492732dc7c6mr817150f8f.1.1793901709728; 
 Thu, 05 Nov 2026 10:01:49 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd43bsm11001023f8f.14.2026.11.05.10.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:01:49 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: Peter Xu <peterx@redhat.com>
Cc: den@openvz.org, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] hostmem: fix cpr-exec of VMs with bound guest memory
Date: Thu,  5 Nov 2026 19:01:45 +0100
Message-ID: <20261105180146.2959656-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <asaPlV0HAyfQm_PS@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260924125800.4188406-1-den@openvz.org>
 <20260924125800.4188406-2-den@openvz.org>
 <cd0292cf-2a87-4716-a8c9-d87853949c76@maciej.szmigiero.name>
 <asZaCerfcnfmAlIw@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <6144855c-f231-41a4-ac6e-b47760b7c8ce@virtuozzo.com>
 <asaPlV0HAyfQm_PS@zhexu-thinkpadt14gen5.rmtcaon.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=den@openvz.org; helo=mail-wr1-x42e.google.com
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 07, 2026 at 02:29:41PM -0400, Peter Xu wrote:
> One thing I can think of that we need host-nodes= is when different
> backends may be bound to different numa node, but since the current use
> case already enabled memcg and looks like it can shift to completely
> different numa nodes, it doesn't seem to be the case.

That is how these VMs start: libvirt turns the guest NUMA topology it
gets from OpenStack into one backend per guest node, each with its own
host-nodes. The cpuset is moved later, and not by libvirt, which
refuses to change the nodeset of a running domain in strict mode. I
agree that host-nodes plus a moving cpuset is not a setup to
recommend, but it is what the stack gives us.

> So it looks like a real issue and also looks severe, but it's a matter of
> whether it should be fixed in qemu. If we want to fix it in QEMU, we
> should have some solid reasoning.

QEMU never asks the kernel for a static binding. It calls mbind()
with MPOL_MF_STRICT | MPOL_MF_MOVE and without MPOL_F_STATIC_NODES.
Without that flag the kernel contract is that the nodemask follows the
cpuset: when cpuset.mems changes, the policy is rebound to the new
nodes (Documentation/admin-guide/mm/numa_memory_policy.rst, the
MPOL_F_STATIC_NODES section), and on cgroup v2 the pages are migrated
with it (cgroup-v2.rst, cpuset.mems). By the time of the update the
running QEMU had its policy rebound and its pages on the new nodes,
and the guest ran fine.

The incoming CPR QEMU is the only one that objects. It takes the
nodemask from the command line and re-applies it to memory it did not
allocate and the kernel has already moved. host-nodes no longer
intersects cpuset.mems, so mbind() fails with EINVAL before it looks
at a single page, and QEMU exits. The EINVAL itself is documented
kernel behaviour. What QEMU adds on top is a lost guest.

A normal migration destination never sees this: it is a fresh process
which the management layer places before it starts. With CPR the new
process inherits memory that has a history. Steve fixed the same class
of problem for ROM contents (b42f28111e), pflash (e56ba1878f), PCI and
vfio-pci reset (24c156dcd9, 031fbb7110) and IOMMU mappings
(6ff4cccd13): realize must not redo what the old process already did
to state that CPR preserved. 2b7e9739fa made the backends inherit
their fd, but the mbind() and prealloc tail of
host_memory_backend_memory_complete() still treats the memory as new.

Prealloc, when enabled, is the same story. It runs MADV_POPULATE_WRITE
over the whole inherited guest RAM while the guest is stopped. That is
downtime growing with the RAM size, spent on pages that already exist.

Maciej is right about extra backends. A backend the old QEMU did not
have gets a fresh fd because cpr_find_fd() finds nothing for it, yet
cpr_is_incoming() is true, so v1 would skip its binding too. v2
decides per backend, by whether its fd was inherited. For an inherited
backend it still calls mbind(), reports a failure with warn_report()
naming the backend, as Maciej suggested, and skips prealloc.
Continuing after a failed mbind() is safe: at fault time the kernel
ignores a bind policy with no node in the cpuset and allocates from
the cpuset. Backends created fresh in the new process keep today's
behaviour.

Peter, would that work for you? I would rather agree on the direction
before sending v2.

Den

