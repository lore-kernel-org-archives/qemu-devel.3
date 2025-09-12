Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B29CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 09:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzdL-0005F4-82; Fri, 12 Sep 2025 04:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwzdJ-0005E6-QO
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwzd9-0000DK-Vo
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757667581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=ewxTlh5vEbdSqb4nj8EbEVqZ7bdeP2fsxuDDzEABHJU=;
 b=I+kmCPwSP47ME4C6og87BaZC0bubDlC/XtflBxjhzpa/C0Ybey7HAVvO1FVlc1WUCYNZ7T
 DcOrungqlZciltwDmSzeBdCyl4l/gVS0rVb8JVUfktRjk1Y/cebc2APW7ZGrnJVoepDB15
 9OLtYGkgX1k+sljPJsr/q/DSXNz1K/g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-NPO6A5k6NaKxvnVZLmRA6w-1; Fri,
 12 Sep 2025 04:59:37 -0400
X-MC-Unique: NPO6A5k6NaKxvnVZLmRA6w-1
X-Mimecast-MFC-AGG-ID: NPO6A5k6NaKxvnVZLmRA6w_1757667576
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA6CD1800366; Fri, 12 Sep 2025 08:59:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C3DB19560B1; Fri, 12 Sep 2025 08:59:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8239D21E6A27; Fri, 12 Sep 2025 10:59:32 +0200 (CEST)
Resent-To: richard.henderson@linaro.org, alifm@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 jjherne@linux.ibm.com, jrossi@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, walling@linux.ibm.com, zycai@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Fri, 12 Sep 2025 10:59:32 +0200
Resent-Message-ID: <87jz24avwr.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com,  berrange@redhat.com,  richard.henderson@linaro.org,
 david@redhat.com,  jrossi@linux.ibm.com,  qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org,  walling@linux.ibm.com,  jjherne@linux.ibm.com,
 pasic@linux.ibm.com,  borntraeger@linux.ibm.com,  farman@linux.ibm.com,
 mjrosato@linux.ibm.com,  iii@linux.ibm.com,  eblake@redhat.com,
 alifm@linux.ibm.com
Subject: Re: [PATCH v5 01/29] Add boot-certs to s390-ccw-virtio machine type
 option
In-Reply-To: <ffb4d32b-d2bc-45f0-91ce-6472d64c02bb@linux.ibm.com> (Zhuoying
 Cai's message of "Thu, 11 Sep 2025 15:03:37 -0400")
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-2-zycai@linux.ibm.com>
 <87v7lpjvsw.fsf@pond.sub.org>
 <ffb4d32b-d2bc-45f0-91ce-6472d64c02bb@linux.ibm.com>
Date: Fri, 12 Sep 2025 08:42:10 +0200
Message-ID: <87wm64b29p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Zhuoying Cai <zycai@linux.ibm.com> writes:

> Thanks for the feedback.
>
> On 9/11/25 3:24 AM, Markus Armbruster wrote:
>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>> 
>>> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
>>> machine. This allows users to specify one or more certificate file paths
>>> or directories to be used during secure boot.
>>>
>>> Each entry is specified using the syntax:
>>> 	boot-certs.<index>.path=/path/to/cert.pem
>>>
>>> Multiple paths can be specify using array properties:
>>> 	boot-certs.0.path=/path/to/cert.pem,
>>> 	boot-certs.1.path=/path/to/cert-dir,
>>> 	boot-certs.2.path=/path/to/another-dir...
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> ---
>>>  docs/system/s390x/secure-ipl.rst   | 20 ++++++++++++++++++++
>>>  hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
>>>  include/hw/s390x/s390-virtio-ccw.h |  2 ++
>>>  qapi/machine-s390x.json            | 24 ++++++++++++++++++++++++
>>>  qemu-options.hx                    |  6 +++++-
>>>  5 files changed, 81 insertions(+), 1 deletion(-)
>>>  create mode 100644 docs/system/s390x/secure-ipl.rst
>>>
>>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>>> new file mode 100644
>>> index 0000000000..9b3fd25cc4
>>> --- /dev/null
>>> +++ b/docs/system/s390x/secure-ipl.rst
>>> @@ -0,0 +1,20 @@
>>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +Secure IPL Command Line Options
>>> +===============================
>>> +
>>> +New parameters have been introduced to s390-ccw-virtio machine type option
>>> +to support secure IPL. These parameters allow users to provide certificates
>>> +and enable secure IPL directly via the command line.
>> 
>> All too soon these parameters will no longer be new.  Consider something
>> like "The s390-ccw-virtio machine type supports secure TPL.  To enable
>> it, you need to provide certificates."
>> 
>>> +
>>> +Providing Certificates
>>> +----------------------
>>> +
>>> +The certificate store can be populated by supplying a list of certificate file
>>> +paths or directories on the command-line:
>> 
>> File is clear enough (use the certificate found in the file).  What does
>> directory do?
>
> A directory contains a list of certificate files, and allowing both
> files and directories could make the CLI more flexible.

I figure when @path names a file, it's an error when the file doesn't
contain a valid cetificate.

What is @path names a directory, and one of the directory's files
doesn't contain a valid certificate?

Can a single file contain multiple certificates?

>>> +
>>> +.. code-block:: shell
>>> +
>>> +    qemu-system-s390x -machine s390-ccw-virtio, \
>>> +                               boot-certs.0.path=/.../qemu/certs, \
>>> +                               boot-certs.1.path=/another/path/cert.pem ...
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index c294106a74..9ac425c695 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -45,6 +45,7 @@
>>>  #include "target/s390x/kvm/pv.h"
>>>  #include "migration/blocker.h"
>>>  #include "qapi/visitor.h"
>>> +#include "qapi/qapi-visit-machine-s390x.h"
>>>  #include "hw/s390x/cpu-topology.h"
>>>  #include "kvm/kvm_s390x.h"
>>>  #include "hw/virtio/virtio-md-pci.h"
>>> @@ -798,6 +799,30 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
>>>      g_free(val);
>>>  }
>>>  
>>> +static void machine_get_boot_certs(Object *obj, Visitor *v,
>>> +                                   const char *name, void *opaque,
>>> +                                   Error **errp)
>>> +{
>>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>>> +    BootCertPathList **certs = &ms->boot_certs;
>>> +
>>> +    visit_type_BootCertPathList(v, name, certs, errp);
>>> +}
>>> +
>>> +static void machine_set_boot_certs(Object *obj, Visitor *v, const char *name,
>>> +                                   void *opaque, Error **errp)
>>> +{
>>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>>> +    BootCertPathList *cert_list = NULL;
>>> +
>>> +    visit_type_BootCertPathList(v, name, &cert_list, errp);
>>> +    if (!cert_list) {
>>> +        return;
>>> +    }
>>> +
>>> +    ms->boot_certs = cert_list;
>>> +}
>>> +
>>>  static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>>>  {
>>>      MachineClass *mc = MACHINE_CLASS(oc);
>>> @@ -851,6 +876,11 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>>>              "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
>>>              " to upper case) to pass to machine loader, boot manager,"
>>>              " and guest kernel");
>>> +
>>> +    object_class_property_add(oc, "boot-certs", "BootCertPath",
>> 
>> Isn't this a BootCertPathList, not a BootCertPath?
>
> If I understand correctly, would BootCerts also be the correct option to
> use here?

This is object_class_property_add()'s @type argument.  It's an arbitrary
string, not checked in any way.  When the property's actual type is a
QAPI type, like it is here, then the @type argument should be the name
of the QAPI type.

Questions?

>>> +                              machine_get_boot_certs, machine_set_boot_certs, NULL, NULL);
>>> +    object_class_property_set_description(oc, "boot-certs",
>>> +            "provide paths to a directory and/or a certificate file for secure boot");
>>>  }
>>>  
>>>  static inline void s390_machine_initfn(Object *obj)
>>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
>>> index 526078a4e2..b90949355c 100644
>>> --- a/include/hw/s390x/s390-virtio-ccw.h
>>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>>> @@ -14,6 +14,7 @@
>>>  #include "hw/boards.h"
>>>  #include "qom/object.h"
>>>  #include "hw/s390x/sclp.h"
>>> +#include "qapi/qapi-types-machine-s390x.h"
>>>  
>>>  #define TYPE_S390_CCW_MACHINE               "s390-ccw-machine"
>>>  
>>> @@ -31,6 +32,7 @@ struct S390CcwMachineState {
>>>      uint8_t loadparm[8];
>>>      uint64_t memory_limit;
>>>      uint64_t max_pagesize;
>>> +    BootCertPathList *boot_certs;
>>>  
>>>      SCLPDevice *sclp;
>>>  };
>>> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
>>> index 966dbd61d2..3e89ef8320 100644
>>> --- a/qapi/machine-s390x.json
>>> +++ b/qapi/machine-s390x.json
>>> @@ -119,3 +119,27 @@
>>>  { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
>>>    'features': [ 'unstable' ]
>>>  }
>>> +
>>> +##
>>> +# @BootCertPath:
>>> +#
>>> +# Boot certificate path.
>>> +#
>>> +# @path: path of certificate(s)
>>> +#
>>> +# Since: 10.1
>>> +##
>> 
>> No mention of file vs. directory.
>> 
>> Why do you wrap the file name in a struct?  One possible reason is
>> providing for future extensions.  Can you think of any?
>> 
>> If you extend it, the name BootCertPath could become suboptimal.
>> BootCertificate?
>> 
>
> I wrapped the path in a struct to follow the array-style structure used
> by cxl-fmw and smp-cache options (as Daniel suggested).
>
> ```
>   It would be something like this on the CLI:
>
>
> boot-certs.0.path=/path/to/dir,boot-certs.1.path=/to/other/dir,boot-certs.2.path=/some/...
> ```
>
> This could potentially leave room for future extensions, such as
> including details about the certificate (e.g., issuer, hashing
> algorithm, etc).

No objections to the wrapping.  I'd prefer naming the struct
BootCertificates.

>>> +{ 'struct': 'BootCertPath',
>>> +  'data': {'path': 'str'} }
>>> +
>>> +##
>>> +# @BootCerts:
>>> +#
>>> +# List of boot certificate paths.
>>> +#
>>> +# @boot-certs: List of BootCertPath
>> 
>> Anti-pattern: the description text restates the type.
>> 
>>> +#
>>> +# Since: 10.1
>>> +##
>>> +{ 'struct': 'BootCerts',
>>> +  'data': {'boot-certs': ['BootCertPath'] } }
>> 
>> Where is this type used?
>
> Please correct me if I'm wrong, but from what I've seen, it is not used
> directly in the implementation. It provides a list property for
> BootCertPath, which makes the BootCertPathList definition valid and able
> to accept multiple paths. If BootCerts is removed, then BootCertPathList
> becomes underfined and results in compilation errors.

Aha!

Your QOM property setter and getter need visit_type_BootCertPathList().

The QAPI generator generates code for BootCertPathList, including
visit_type_BootCertPathList(), only when it knows it's actually used.
It can only see uses within the QAPI schema.  So, when ['BootCertPath']
doesn't occur there, visit_type_BootCertPathList() won't exist, and your
QOM code won't compile.

Since you don't actually need BootCertPathList in the schema, you need
to add an artifical use just to get it generated.  The common way to do
that is using it in a dummy type like this:

    ##
    # @DummyForceS390Arrays:
    #
    # Not used by QMP; hack to let us use BootCertPathList internally
    #
    # Since: 10.2
    ##
    { 'struct': 'DummyForceArrays',
      'data': { 'unused': ['BootCertPath'] } }

You also need to add it to pragme documentation-exceptions is
pragma.json.

Yes, this is clunky.  Sorry :)

[...]


