Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFBCCD8C8E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 13:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVrNS-0002Md-Ul; Sat, 06 Jun 2026 09:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dev@khalid-dermoumi.de>)
 id 1wVmTt-0007xy-6B
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 04:34:13 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dev@khalid-dermoumi.de>)
 id 1wVmTr-0006r2-JM
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 04:34:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1780734846; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=eqS90+HXr69V2xphfGeGN6SzbqxdY0lvWw0u1PdUlKWA3PmM16oHeMN3bEc2ipGs7G
 eO52vq+Tyyl7GkL0sJLDrSDOcN/7WIqQECSwfPqy6xCeUAbS8fnq+UudgAhQYTHk6AqG
 w0UXoAtMU+OrLle1EayE7GkocYlaYb9rYvjEw7/1LjoDsIHSchraU0KWbi09R8XLW6IC
 oSzRrPW99mqdODyG9p/99I7usVq38N7GD6/Jc3HpA0NAFeJ3pG1/9CnUSB7r5u0BYIBh
 4PHDwveYkW7h3XbcOs4YoksnHl7FcN4NKPWNfmRsukNvCdyYo9M7s0Yi/WQjdkYJzYFs
 PikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1780734846;
 s=strato-dkim-0002; d=strato.com;
 h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
 bh=gjlwTj5VRlbHmbNZ3jVGgGYA98v6hXIlekzcnaNtpzY=;
 b=VsxmgE5EGXhQR870P2rQbijBZcay5U8VD5ctVqd/bCCxb/kztSrVwdr6iamsOhAEns
 PzCjpvqlENusO6jyS+vFu+PUiXZ0whIheg3zAdgCE+mp1E3TbYuQZXNCpOXTvxfivzTe
 FJ2S+rkZSMurXzzZGReAoAHJu7oMNa69iMnQ90Qp5bh5JVdmVFoyz8+xPd/cArzQOlcN
 063ECelk1yMSO5NZNGD1f4EGSasBTATyabAMeNPsX8y2zlpfFlqWyj01KINCRx0GgXXd
 XLxxYJWZLMNBaAPJzeFLqA0oy/bhZGbWoPYUPzhlcMu6sSni2ex/h/toeI/ux6pCPYYN
 rm8g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1780734846;
 s=strato-dkim-0002; d=khalid-dermoumi.de;
 h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
 bh=gjlwTj5VRlbHmbNZ3jVGgGYA98v6hXIlekzcnaNtpzY=;
 b=QWaNx//uFpLj36ipFJnDalRcZIwdc17URslLbaZ5pWGX6MZ9vwf9RfgNT+qpJDOSx1
 VMq6SOH1cphMVUdyfv59d/HKiRRchCQuEJW6/8ihuiaAgdIJ+cubpb4kYaeB1Y/2muAm
 g8q0BXrFpamo3wmF556OPUoekq/ud1qBVoCB9V6h3oExshK7Hku0Jo0C39blygElRBt0
 38xK8SEuvjQf7h0s0+zeOEsOpoDxPvsBXVQwulyLqo4MAODRx5K5TwQ1HAa0acs8Fma6
 fascV3TrN6D8ojYRezfWmE1ZwpUrwSFDJgjns+iEiGVqj3sSilsQNuy2DI5JT1NUzLJa
 M82w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1780734846;
 s=strato-dkim-0003; d=khalid-dermoumi.de;
 h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
 bh=gjlwTj5VRlbHmbNZ3jVGgGYA98v6hXIlekzcnaNtpzY=;
 b=SXB2dA66GSQxSxvQ895O2zIIQmcJSjGQ0BPDxglpP6DTgzJ4nQRVH7bDM3qE+3hWoJ
 EQHP/e9OR+cf64nxbGAQ==
X-RZG-AUTH: ":J2gkfkipd/bPzGFzmGBYdHWvXeeTZnzuxeuq1/CUEEtdRcNCxKO3CF8tfqoeLgzSwhwq"
Received: from [192.168.111.131] by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
 with ESMTPSA id 974b132568Y6fXH
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate) for <qemu-devel@nongnu.org>;
 Sat, 6 Jun 2026 10:34:06 +0200 (CEST)
Message-ID: <f59ad48f-c8ef-4bc8-96e4-ef3f0ab7fcdd@khalid-dermoumi.de>
Date: Sat, 6 Jun 2026 10:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Subject: Ubuntu 24.04 guest issue: unable to execute QEMU agent command
 'guest-set-time': this feature or command is not currently supported
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.23;
 envelope-from=dev@khalid-dermoumi.de; helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 06 Jun 2026 09:47:41 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Khalid Dermoumi <dev@khalid-dermoumi.de>
From:  Khalid Dermoumi via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi!

I have an issue with qemu Ubuntu 24.04 guests under kvm and libvirt 
(host is also Ubuntu 24.04). The guests do not get time synced when the 
vms are resumed. When I try to set the time from the host manually, this 
is returned:

khalid@host:~$ virsh qemu-agent-command "virtual-027" 
'{"execute":"guest-set-time"}'
error: internal error: unable to execute QEMU agent command 
'guest-set-time': this feature or command is not currently supported

I am certain that the qemu-guest-agent is running, and otherwise working:

khalid@mobile-009:~$ virsh qemu-agent-command "virtual-027" 
'{"execute":"guest-ping"}'
{"return":{}}

I tried to fix this, and looked at many things, but I couldn't find the 
cause of the issue yet. The vms where running Ubuntu 20.04 before, and 
time sync worked fine. After I upgraded them a few weeks ago, this 
problem appeared.

I would be thankful for any pointers to what's wrong.


Regards,

-- 
Khalid Dermoumi
M: +49 177 6731348
E: dev@khalid-dermoumi.de


