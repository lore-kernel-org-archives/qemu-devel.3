Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0723BCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 18:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw3EW-00021g-NM; Tue, 09 Sep 2025 14:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw3EU-00021M-IB
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 14:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw3EJ-0005O3-Ke
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 14:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757443082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=crZHr0NaGftOqo10csISbr0xbUI2TxUjDucjwXO1GQM=;
 b=OUQvEhrJlRT4LPVTmI8MbvqP7mxIlRyfl7LHLEdYMA27N3ShPQS65HtFasQ3CwpiaB+uFJ
 2qmISLeMALZFPN7A8irenvkj/N9MIS4kxwGOYwMGfWWOUTr6bHsRw0+EC89uC2KvI62bTn
 nU69JW5hsUB+9axdc6YVhxodDyirEUE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-5AwnsVMqMj6AGRt6ow7cPg-1; Tue, 09 Sep 2025 14:38:01 -0400
X-MC-Unique: 5AwnsVMqMj6AGRt6ow7cPg-1
X-Mimecast-MFC-AGG-ID: 5AwnsVMqMj6AGRt6ow7cPg_1757443081
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7ffb4a65951so2350259385a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 11:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757443081; x=1758047881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crZHr0NaGftOqo10csISbr0xbUI2TxUjDucjwXO1GQM=;
 b=QBTqfr6v2fBwA/i871c0cQm7XfyP2kxuGQUK3esLQ0ushxrJGMeYGf0YrSDYlZNV74
 1VcellF7qZfnXFTe+z+NuYGsfyVvNWH5WEl2ycwU/G00DZleO+NpHTjI+lIC1oo7jLHr
 Soix36Eh2olzFwYbi8dHL3KComUXdCsYkxmSsKqNgCW+k8CRrPgdclOvj8ItgJPqnOeA
 QtCswxIegH83flbR/lJ5+hbVww7mxK6/DVQXsDH2uQ5j9tX8RhnzKijJaa+j1nT7LhU2
 YC7DePDGmcg3sKA75PQk3fA0NM82VpALB2v9/yL0O5puTt0Tt/y7BKPJc0LdrrYUj1QG
 wElA==
X-Gm-Message-State: AOJu0Yxl7UiIv6hCwVX8Zwfw+FrdmdtrBv3WzcK9GQER7XTC3GQs7E90
 DXHPlx+/t+2wQQeH+i5zvIKM8e5424/JSWy0Iy/aO91BBMUVSOmOkdzsr5Pf3jvZyrVFYWfEzMO
 DahzEuilAaJQQkjtyfRk32ElCy+Sqm35VDXP0KHDH9xxa36GRGVZKwoiW
X-Gm-Gg: ASbGncvs4i0luZdyW+M1EA38vJhiRgqqjlul+WvKuN1XxA5PsRDvqlLvdohHrxhMqNg
 0Ovk5WyQeV8DEVg3mVueFK1g67CmpzyrgHoAtund4IDwGnQIPHOZj/oX/B/X15UBJuynov0h3hC
 oCtTtXG9OKz6d0kmVkhuVlmzXoJTrFOAiTPl8kKbKmY/MkmtHv4IBALroiBXSfyasfF4VXM3RNO
 649XUO0ODDNEOCUPTNN4d6/O+dpf44PPgIp9LKI4pTIxx9sYy7ognsSIgj/Kbx8pcx5MC0xpGdm
 SHN2w9UDrG2UY3MtKkxked+J3tcNKJqjFbPJ948sQe06kmkNx0/V8ikGSHATaUbFukTAM1R+6/O
 qyItLFq2UTMJXAGdFV4+umg==
X-Received: by 2002:a05:620a:1a99:b0:7e8:4400:d082 with SMTP id
 af79cd13be357-813bf8b5129mr1148521485a.36.1757443080489; 
 Tue, 09 Sep 2025 11:38:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEGymcxc8V7X0HgimxMM6wj9FEn0EMEjbUbZakz5oMZFDIZVaChJHrCxEKyoFic10gT4XCbg==
X-Received: by 2002:a05:620a:1a99:b0:7e8:4400:d082 with SMTP id
 af79cd13be357-813bf8b5129mr1148517085a.36.1757443079683; 
 Tue, 09 Sep 2025 11:37:59 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-81b596e518csm162076785a.24.2025.09.09.11.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 11:37:59 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:37:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
Message-ID: <aMB0BL5SEGfwjTFm@x1.local>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <aLsUQWjW8gyZjySs@x1.local>
 <fd56205a-11c1-4297-898d-603f1836bdad@oracle.com>
 <aMBGnHXieiXpBCqF@x1.local>
 <992bf553-e622-4e51-b1c7-f59c1413558e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <992bf553-e622-4e51-b1c7-f59c1413558e@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 09, 2025 at 12:03:11PM -0400, Steven Sistare wrote:
> On 9/9/2025 11:24 AM, Peter Xu wrote:
> > On Tue, Sep 09, 2025 at 10:36:16AM -0400, Steven Sistare wrote:
> > > On 9/5/2025 12:48 PM, Peter Xu wrote:
> > > > Add Vladimir and Dan.
> > > > 
> > > > On Thu, Aug 14, 2025 at 10:17:14AM -0700, Steve Sistare wrote:
> > > > > This patch series adds the live migration cpr-exec mode.
> > > > > 
> > > > > The new user-visible interfaces are:
> > > > >     * cpr-exec (MigMode migration parameter)
> > > > >     * cpr-exec-command (migration parameter)
> > > > > 
> > > > > cpr-exec mode is similar in most respects to cpr-transfer mode, with the
> > > > > primary difference being that old QEMU directly exec's new QEMU.  The user
> > > > > specifies the command to exec new QEMU in the migration parameter
> > > > > cpr-exec-command.
> > > > > 
> > > > > Why?
> > > > > 
> > > > > In a containerized QEMU environment, cpr-exec reuses an existing QEMU
> > > > > container and its assigned resources.  By contrast, cpr-transfer mode
> > > > > requires a new container to be created on the same host as the target of
> > > > > the CPR operation.  Resources must be reserved for the new container, while
> > > > > the old container still reserves resources until the operation completes.
> > > > > Avoiding over commitment requires extra work in the management layer.
> > > > 
> > > > Can we spell out what are these resources?
> > > > 
> > > > CPR definitely relies on completely shared memory.  That's already not a
> > > > concern.
> > > > 
> > > > CPR resolves resources that are bound to devices like VFIO by passing over
> > > > FDs, these are not over commited either.
> > > > 
> > > > Is it accounting QEMU/KVM process overhead?  That would really be trivial,
> > > > IMHO, but maybe something else?
> > > 
> > > Accounting is one issue, and it is not trivial.  Another is arranging exclusive
> > > use of a set of CPUs, the same set for the old and new container, concurrently.
> > > Another is avoiding namespace conflicts, the kind that make localhost migration
> > > difficult.
> > > 
> > > > > This is one reason why a cloud provider may prefer cpr-exec.  A second reason
> > > > > is that the container may include agents with their own connections to the
> > > > > outside world, and such connections remain intact if the container is reused.
> > > > 
> > > > We discussed about this one.  Personally I still cannot understand why this
> > > > is a concern if the agents can be trivially started as a new instance.  But
> > > > I admit I may not know the whole picture.  To me, the above point is more
> > > > persuasive, but I'll need to understand which part that is over-commited
> > > > that can be a problem.
> > > 
> > > Agents can be restarted, but that would sever the connection to the outside
> > > world.  With cpr-transfer or any local migration, you would need agents
> > > outside of old and new containers that persist.
> > > 
> > > With cpr-exec, connections can be preserved without requiring the end user
> > > to reconnect, and can be done trivially, by preserving chardevs.  With that
> > > support in qemu, the management layer does nothing extra to preserve them.
> > > chardev support is not part of this series but is part of my vision,
> > > and makes exec mode even more compelling.
> > > 
> > > Management layers have a lot of code and complexity to manage live migration,
> > > resources, and connections.  It requires modification to support cpr-transfer.
> > > All that can be bypassed with exec mode.  Less complexity, less maintainance,
> > > and  fewer points of failure.  I know this because I implemented exec mode in
> > > OCI at Oracle, and we use it in production.
> > 
> > I wonders how this part works in Vladimir's use case.
> > 
> > > > After all, cloud hosts should preserve some extra memory anyway to make
> > > > sure dynamic resources allocations all the time (e.g., when live migration
> > > > starts, KVM pgtables can drastically increase if huge pages are enabled,
> > > > for PAGE_SIZE trackings), I assumed the over-commit portion should be less
> > > > that those.. and when it's also temporary (src QEMU will release all
> > > > resources after live upgrade) then it looks manageable. >>
> > > > > How?
> > > > > 
> > > > > cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
> > > > > and by sending the unique name and value of each descriptor to new QEMU
> > > > > via CPR state.
> > > > > 
> > > > > CPR state cannot be sent over the normal migration channel, because devices
> > > > > and backends are created prior to reading the channel, so this mode sends
> > > > > CPR state over a second migration channel that is not visible to the user.
> > > > > New QEMU reads the second channel prior to creating devices or backends.
> > > > > 
> > > > > The exec itself is trivial.  After writing to the migration channels, the
> > > > > migration code calls a new main-loop hook to perform the exec.
> > > > > 
> > > > > Example:
> > > > > 
> > > > > In this example, we simply restart the same version of QEMU, but in
> > > > > a real scenario one would use a new QEMU binary path in cpr-exec-command.
> > > > > 
> > > > >     # qemu-kvm -monitor stdio
> > > > >     -object memory-backend-memfd,id=ram0,size=1G
> > > > >     -machine memory-backend=ram0 -machine aux-ram-share=on ...
> > > > > 
> > > > >     QEMU 10.1.50 monitor - type 'help' for more information
> > > > >     (qemu) info status
> > > > >     VM status: running
> > > > >     (qemu) migrate_set_parameter mode cpr-exec
> > > > >     (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
> > > > >     (qemu) migrate -d file:vm.state
> > > > >     (qemu) QEMU 10.1.50 monitor - type 'help' for more information
> > > > >     (qemu) info status
> > > > >     VM status: running
> > > > > 
> > > > > Steve Sistare (9):
> > > > >     migration: multi-mode notifier
> > > > >     migration: add cpr_walk_fd
> > > > >     oslib: qemu_clear_cloexec
> > > > >     vl: helper to request exec
> > > > >     migration: cpr-exec-command parameter
> > > > >     migration: cpr-exec save and load
> > > > >     migration: cpr-exec mode
> > > > >     migration: cpr-exec docs
> > > > >     vfio: cpr-exec mode
> > > > 
> > > > The other thing is, as Vladimir is working on (looks like) a cleaner way of
> > > > passing FDs fully relying on unix sockets, I want to understand better on
> > > > the relationships of his work and the exec model.
> > > 
> > > His work is based on my work -- the ability to embed a file descriptor in a
> > > migration stream with a VMSTATE_FD declaration -- so it is compatible.
> > > 
> > > The cpr-exec series preserves VMSTATE_FD across exec by remembering the fd
> > > integer and embedding that in the data stream.  See the changes in vmstate-types.c
> > > in [PATCH V3 7/9] migration: cpr-exec mode.
> > > 
> > > Thus cpr-exec will still preserve tap devices via Vladimir's code.
> > > > I still personally think we should always stick with unix sockets, but I'm
> > > > open to be convinced on above limitations.  If exec is better than
> > > > cpr-transfer in any way, the hope is more people can and should adopt it.
> > > 
> > > Various people and companies have expressed interest in CPR and want to explore
> > > cpr-exec.  Vladimir was one, he chose transfer instead, and that is fine, but
> > > give people the option.  And Oracle continues to use cpr-exec mode.
> > 
> > How does cpr-exec guarantees everything will go smoothly with no failure
> > after the exec?  Essentially, this is Vladimir's question 1.
> 
> Live migration can fail if dirty memory copy does not converge.  CPR does not.

As we're comparing cpr-transfer and cpr-exec, this one doesn't really count, AFAIU.

> cpr-transfer can fail if it fails to create a new container.  cpr-exec cannot.
> cpr-transfer can fail to allocate resources.  cpr-exec needs less.

These two could happen in very occpied hosts indeed, but is it really that
common an issue when ignoring the whole guest memory section after all?

> 
> cpr-exec failure is almost always due to a QEMU bug.  For example, a new feature
> has been added to new QEMU, and is *not* forced to false in a compatibility entry
> for the old machine model. We do our best to find and fix those before going into
> production. In production, the success rate is high. That is one reason I like the
> mode so much.

Yes, but this is still a major issue.  The problem is I don't think we have
good way to provide 100% coverage on the code base covering all kinds of
migrations.

After all, we have tons of needed() fields in VMSD, we need to always be
prepared that the migration stream can change from time to time with
exactly the same device setup, and some of them may prone to put() failures
on the other side.

After all, live migration was designed to be fine with such, so at least VM
won't crash on src if anything happens.

Precopy always does that, we're trying to make postcopy do the same, which
Juraj is working on, so that postcopy can FAIL and rollback to src too if
device state doesn't apply all fine.

It's still not uncommon to have guest OS / driver behavior change causing
some corner case migration failures but only when applying the states.

That's IMHO a high risk even if low possibility.

> 
> > Feel free to
> > answer there, because there's also question 2 (which we used to cover some
> > but maybe not as much).
> 
> Question 2 is about minimizing downtime by starting new QEMU while old QEMU
> is still running.  That is true, but the savings are small.

I thought we discussed about this, and it should be known to have at least
below two major part of things that will increase downtime (either directly
accounted into downtime, or slow down vcpus later)?

  - Process pgtable, aka, QEMU's view of guest mem
  - EPT pgtable, aka, vCPU's view of guest mem

Populating these should normally take time when VM becomes huge, while
cpr-transfer can still benefit on pre-populations before switchover.

IIUC that's a known issue, but please correct me if I remembered it wrong.
I think it means this issue is more severe with larger VMs, which is a
trade-off.  It's just that I don't know what else might be relevant.

Personally I don't think this is a blocker for cpr-exec, but we should IMHO
record the differences.  It would be best, IMHO, to have a section in
cpr.rst to discuss this, helping user decide which to choose when both
benefits from CPR in general.

Meanwhile, just to mention unit test for cpr-exec is still missing.

> > The other thing I don't remember if we discussed, on how cpr-exec manages
> > device hotplugs. Say, what happens if there are devices hot plugged (via
> > QMP) then cpr-exec migration happens?One method: start new qemu with the original command-line arguments plus -S, then
> mgmt re-sends the hot plug commands to the qemu monitor.  Same as for live
> migration.
> > Does cpr-exec cmdline needs to convert all QMP hot-plugged devices into
> > cmdlines and append them?
> That also works, and is a technique I have used to reduce guest pause time.
> 
> > How to guarantee src/dst device topology match
> > exactly the same with the new cmdline?
> 
> That is up to the mgmt layer, to know how QEMU was originally started, and
> what has been hot plugged afterwards.  The fast qom-list-get command that
> I recently added can help here.

I see.  If you think that is the best way to consume cpr-exec, would you
add a small section into the doc patch for it as well?

-- 
Peter Xu


