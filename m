Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EACC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCrF-0004jO-Iv; Mon, 01 Jul 2024 04:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sOCqC-0004M6-JH; Mon, 01 Jul 2024 04:56:53 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sOCq6-0006XT-9q; Mon, 01 Jul 2024 04:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=073QRSIAljNanot71WKMUobh9NY8CTxpm8fYzTNnETI=; b=IAGZwfzSAGCnv6eig9Rk1EIa1A
 sHknzLgyC/jfGArWZ3bWm+yJ2vSgnnoDrSWbgGF7qY8bB9eqByvFIr790WKhVtoT5pJBnoIz0j3d/
 8fnrztwxfbqoZg1qMO2JtTHVLr/x7YGhZznzu4JMwGNc16MH7mzQu3U5hNu1ktVcXKu18DH3E0u7h
 SQJfytJcMNt9WWXnCZFjrPWhUmMwWfa1MTEOLQEnneErJ4r3R8BvEH69RAlgsGPjXPudQMXVupQsk
 /Up7XWk4K15rucGOLHpW3ZgCWJb/7TUXd8a6cpy90U2rpd5Hx8lstX51gcir0viVowG/e0NBC+SnJ
 aD5+Pbyg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sOCpt-009m7w-D4; Mon, 01 Jul 2024 10:56:33 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1sOCpr-00EQSH-3s; Mon, 01 Jul 2024 10:56:33 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1sOCpq-00G78q-36;
 Mon, 01 Jul 2024 08:56:30 +0000
From: Alberto Garcia <berto@igalia.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna
 Czenczek <hreitz@redhat.com>, Madeeha Javed <javed@igalia.com>
Subject: Re: [PATCH] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
In-Reply-To: <eyt18.e0s2rty6vd9y@linaro.org>
References: <20240610144708.81351-1-berto@igalia.com>
 <eyt18.e0s2rty6vd9y@linaro.org>
Date: Mon, 01 Jul 2024 10:56:30 +0200
Message-ID: <w51sewtpk1t.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed 12 Jun 2024 02:00:19 PM +03, Manos Pitsidianakis wrote:

Hi, thanks for the review and sorry for taking so long to reply, I was
on vacation.

>> scripts/qcow2-to-stdout.py | 330 +++++++++++++++++++++++++++++++++++++
>> 1 file changed, 330 insertions(+)
>> create mode 100755 scripts/qcow2-to-stdout.py
>
> I recommend running the `black` formatter on this script, it makes the
> code more diff-friendly and uniform. Also it has become the de-facto
> python style.

Hmmm, I don't like how it reformats some of the lines. However other
changes do make sense, so I'll apply those.

> Also, it's more pythonic to name constants in uppercase, like
> allocated_l2_tables. You can check such lints with pylint
> scripts/qcow2-to-stdout.py

allocated_l2_tables is not a constant :-?

>>+    struct.pack_into('>I', header, 0x70, 0x6803f857)
>>+    struct.pack_into('>I', header, 0x74, len(qcow2_features) * 48)
>>+    cur_offset = 0x78
>
> Minor comment: extract magic values/offsets into constant globals with
> descriptive names, it'd help the code be more readable and easier to
> maintain if ported in the future to other formats.

Good idea, will do.

>>+    for (feature_type, feature_bit, feature_name) in qcow2_features:
>>+        struct.pack_into('>BB46s', header, cur_offset,
>>+                         feature_type, feature_bit, feature_name.encode('ascii'))
>>+        cur_offset += 48
>>+
>
>>From here onwards put everything under a main block like so:

Ok.

>>+# Command-line arguments
>>+parser = argparse.ArgumentParser(description='This program converts a QEMU disk image to qcow2 '
>>+                                 'and writes it to the standard output')
>>+parser.add_argument('input_file', help='name of the input file')
>
> Suggestion:
>
> -parser.add_argument('input_file', help='name of the input file')
> +parser.add_argument('input_file', help='name of the input file', type=pathlib.Path, required=True)

'required' is not valid in positional arguments, and I'm not sure what
benefits using pathlib brings in this case.

>>+parser.add_argument('-v', dest='qcow2_version', metavar='qcow2_version',
>
> Maybe -q instead of -v? No strong feelings on this one, it's just that 
> -v is usually version. -q is also usually --quiet so not sure...

Yeah, I thought the same but I didn't want to complicate this too much,
this is just a helper script.

>>+# If the input file is not in raw format we can use
>>+# qemu-storage-daemon to make it appear as such
>>+if input_format != 'raw':
>>+    temp_dir = tempfile.mkdtemp()
>
> Consider using the tempfile.TemporaryDirectory as with... context 
> manager so that the temp dir cleanup is performed automatically

I don't think I can do that directly here because the temp dir has to
live until the very end (qemu-storage-daemon needs it).

>>+    pid_file = temp_dir + "/pid"
>>+    raw_file = temp_dir + "/raw"
>>+    open(raw_file, 'wb').close()
>
> Consider using a with open(...) open manager for opening the file

How would that be? Like this?

    with open(raw_file, 'wb'):
        pass

If so I don't see the benefit, I just need to create an empty file and
close it immediately.

>>+    atexit.register(kill_storage_daemon, pid_file, raw_file, temp_dir)
>
> Hm, this too could be a context manager. Seems very C-like to use
> atexit here.

Yeah it is, but I think that using the context manager would require me
to split the main function in two, and I'm not sure that it's worth it
for this case. Other Python scripts in the QEMU repo use atexit already.

>>+    ret = subprocess.run(["qemu-storage-daemon", "--daemonize", "--pidfile", pid_file,
>>+                          "--blockdev", f"driver=file,node-name=file0,driver=file,filename={input_file},read-only=on",
>>+                          "--blockdev", f"driver={input_format},node-name=disk0,file=file0,read-only=on",
>>+                          "--export", f"type=fuse,id=export0,node-name=disk0,mountpoint={raw_file},writable=off"])
>
> You can add shell=True, check=False arguments to subprocess.run() so 
> that it captures the outputs. (check=False is the default behavior, but 
> better make it explicit)

I'm not sure that I understand, why would I need to use a shell here?

>>+sys.stdout.buffer.write(cluster)
>
> Would it be a good idea to check if stdout is a tty and not a
> pipe/redirection? You can check it with isatty() and error out to
> prevent printing binary to the terminal.

Yeah this is a good idea, thanks.

Berto

