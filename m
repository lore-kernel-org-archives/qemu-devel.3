Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E00C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94iO-0004xK-0v; Tue, 22 Sep 2026 13:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x94iK-0004wf-2r
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x94iG-0000lq-Re
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790099727;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0OTBXR67uNgzDd3AbnxlYqcSVuzRI6QWcIbkJauaiT4=;
 b=HN8znksudn9qsKgzHCB0mzIT6TH6GWO+zXsgneUfO3ePefcL6utpnLqZrF/yuT5Fi0sR7X
 RiMe4+754BC7utYnVoxfV38yhdc4Ec8jJL8o/JNgv5jViKAsqAOgxpx36p2cbd20k1z8Ii
 pBsL5Ot0Ijmr68VTveZWN+1LrYkn41s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-IZYJ_oqmOGmxrEoQCLwTug-1; Tue,
 22 Sep 2026 13:55:23 -0400
X-MC-Unique: IZYJ_oqmOGmxrEoQCLwTug-1
X-Mimecast-MFC-AGG-ID: IZYJ_oqmOGmxrEoQCLwTug_1790099722
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 734DB1933B57; Tue, 22 Sep 2026 17:55:22 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0E3F754; Tue, 22 Sep 2026 17:55:20 +0000 (UTC)
Date: Tue, 22 Sep 2026 18:55:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH 3/7] tests/lci/refresh: add parameter to override
 container registry
Message-ID: <arLBBjS_T40wBa3X@redhat.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-4-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921231458.3369-4-pierrick.bouvier@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 21, 2026 at 11:14:54PM +0000, Pierrick Bouvier wrote:
> We'll use this in next patch to switch FROM docker.io/library to
> docker.io/amd64. It would not make sense to add a new target to
> libvirt-ci for this, since it's just a variant of an existing target.
> Simply replace container registry with arch specific one.

We shouldn't need to add new targets to lcitool for this,
rather it would be enhanced to include a list of arch
specific container images.

eg in

https://gitlab.com/libvirt/libvirt-ci/-/blob/master/lcitool/facts/targets/debian-13.yml?ref_type=heads

We would extend:

  containers:
    base: docker.io/library/debian:13-slim

to allow for

  containers:
    base: docker.io/library/debian:13-slim
    aarch64:  docker.io/amd64/debian:13-slim
    ...more...

such that we default to the 'base' image name, unless
there is an arch specific name defined. That would be
a fairly quick extension to impl in lcitool.

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/lcitool/refresh | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 9a71af0e41d..4e3cbb81acf 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -12,6 +12,7 @@
>  # or (at your option) any later version. See the COPYING file in
>  # the top-level directory.
>  
> +import re
>  import sys
>  import subprocess
>  
> @@ -41,7 +42,7 @@ def atomic_write(filename, content):
>          raise
>  
>  
> -def generate(filename, cmd, trailer):
> +def generate(filename, cmd, trailer, registry_path):
>      print("Generate %s" % filename)
>      lcitool = subprocess.run(cmd, capture_output=True, encoding='utf8')
>  
> @@ -49,6 +50,10 @@ def generate(filename, cmd, trailer):
>          raise Exception("Failed to generate %s: %s" % (filename, lcitool.stderr))
>  
>      content = lcitool.stdout
> +
> +    if registry_path is not None:
> +        content = re.sub("FROM.*/", "FROM " + registry_path + '/', content)
> +
>      if trailer is not None:
>          content += trailer
>      atomic_write(filename, content)
> @@ -64,7 +69,7 @@ add_user_mapping = [
>  ]
>  
>  def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
> -                        enable_rust=True):
> +                        enable_rust=True, registry_path=None):
>      filename = Path(src_dir, "tests", "docker", "dockerfiles", host + ".docker")
>      cmd = lcitool_cmd + ["dockerfile"]
>      if cross is not None:
> @@ -79,26 +84,26 @@ def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
>  
>      if enable_rust:
>          trailer += "\nENV ENABLE_RUST=1\n"
> -    generate(filename, cmd, trailer)
> +    generate(filename, cmd, trailer, registry_path)
>  
>  
>  def generate_vars(target, trailer=None):
>      filename = Path(src_dir, ".gitlab-ci.d", target + ".vars")
>      cmd = lcitool_cmd + ["variables", "--format", "shell", target, "qemu"]
> -    generate(filename, cmd, trailer)
> +    generate(filename, cmd, trailer, None)
>  
>  
>  def generate_pkglist(vm, target, project="qemu"):
>      filename = Path(src_dir, "tests", "vm", "generated", vm + ".json")
>      cmd = lcitool_cmd + ["variables", "--format", "json", target, project]
> -    generate(filename, cmd, None)
> +    generate(filename, cmd, None, None)
>  
>  
>  def generate_yaml(os, target, arch, trailer=None):
>      filename = Path(src_dir, "scripts", "ci", "setup", os, f"{target}-{arch}.yaml")
>      cmd = lcitool_cmd + ["variables", "--format", "yaml", "-a",
>                           arch, target, "qemu"]
> -    generate(filename, cmd, trailer)
> +    generate(filename, cmd, trailer, None)
>  
>  
>  alpine_extras = r"""
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


