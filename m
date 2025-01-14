Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798C4E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 22:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXp8A-00048w-Iy; Tue, 14 Jan 2025 17:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tXp84-00048i-Bt
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 17:11:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tXp82-0006d3-FH
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 17:11:20 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EFDjp1004708;
 Tue, 14 Jan 2025 22:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Fyd1Lx
 BVIpIINvYhQRmeQdceLyXCb0j3bHkd2XaVHoc=; b=DuTvfoZWgEb5TC4P4H75eg
 nHs6Eu+OBbJkOZqGxToyvND8fbXM7ZEBjsardx+lAQcGknlDGSTV1S6fBWmnLNUD
 9ruLXhWTB8SdOPCdOOF686fV7xC0lZJOTqMHAL60AMZtGOpjK/m+gg8/cQgkBoLC
 su4O8iHa1nR/SqkKdNIvD6kYxk4o8xKei3/7kXEJvVWYFcM2lYCvF7Bq+LToZhp4
 lAcL8hKMlOHR2GAJLztfkBAV4nBsL1vVikDCWsGEyPFwKDb/VTvaF/k/EP4myvUQ
 RdMMUZOv48H852vWDiWfUaFg4Kguo+SfdpbUnKXHVOkuMjhjHhOhbZLDlzfEfOsA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445gdjm91a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 22:11:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50ELDeYq002663;
 Tue, 14 Jan 2025 22:11:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443by5eqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 22:11:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50EMBB8K55640526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 22:11:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DFD0205E3;
 Tue, 14 Jan 2025 21:45:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DFFB205E2;
 Tue, 14 Jan 2025 21:45:42 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jan 2025 21:45:42 +0000 (GMT)
Message-ID: <ac7210776db3b844ffb1af1d3e345da235bf986e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 10/37] system: propagate Error to gdbserver_start
 (and other device setups)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Stefan Weil
 <sw@weilnetz.de>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, Laurent
 Vivier <laurent@vivier.eu>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Jan 2025 22:45:42 +0100
In-Reply-To: <20250114113821.768750-11-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
 <20250114113821.768750-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r-N-Ty-DYXuUHWuAuSLuiUY66scxJsih
X-Proofpoint-ORIG-GUID: r-N-Ty-DYXuUHWuAuSLuiUY66scxJsih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.794, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 2025-01-14 at 11:37 +0000, Alex Benn=C3=A9e wrote:
> This started as a clean-up to properly pass a Error handler to the
> gdbserver_start so we could do the right thing for command line and
> HMP invocations.
>=20
> Now that we have cleaned up foreach_device_config_or_exit() in
> earlier
> patches we can further simplify by it by passing &error_fatal instead
> of checking the return value. Having a return value is still useful
> for HMP though so tweak the return to use a simple bool instead.
>=20
> Message-Id: <20250109170619.2271193-11-alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

Apparently the BSD code needs to be adjusted:

../qemu/bsd-user/main.c:631:32: error: too few arguments to function
call, expected 2, have 1
  631 |         gdbserver_start(gdbstub);
      |         ~~~~~~~~~~~~~~~        ^
/home/user/qemu/include/exec/gdbstub.h:63:6: note: 'gdbserver_start'
declared here
   63 | bool gdbserver_start(const char *port_or_device, Error **errp);
      |      ^               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

> ---
> v2
> =C2=A0 - split some work into pre-cursor patches
> ---
> =C2=A0include/exec/gdbstub.h |=C2=A0 8 +++++-
> =C2=A0gdbstub/system.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++++-=
-------
> =C2=A0gdbstub/user.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20=
 ++++++++-------
> =C2=A0linux-user/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +----
> =C2=A0monitor/hmp-cmds.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0system/vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 58 ++++++++++++++++++++--------------------
> --
> =C2=A06 files changed, 59 insertions(+), 57 deletions(-)

[...]

> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index 0b4bfa9c48..fb8f6867ea 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -13,6 +13,7 @@
> =C2=A0#include "qemu/bitops.h"
> =C2=A0#include "qemu/cutils.h"
> =C2=A0#include "qemu/sockets.h"
> +#include "qapi/error.h"
> =C2=A0#include "exec/hwaddr.h"
> =C2=A0#include "exec/tb-flush.h"
> =C2=A0#include "exec/gdbstub.h"
> @@ -372,15 +373,15 @@ static bool gdb_accept_tcp(int gdb_fd)
> =C2=A0=C2=A0=C2=A0=C2=A0 return true;
> =C2=A0}
> =C2=A0
> -static int gdbserver_open_port(int port)
> +static int gdbserver_open_port(int port, Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 struct sockaddr_in sockaddr;
> =C2=A0=C2=A0=C2=A0=C2=A0 int fd, ret;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 fd =3D socket(PF_INET, SOCK_STREAM, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (fd < 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("socket");
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Failed to b=
ind socket: %s",
> strerror(errno));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;

I think return -1 needs to stay here.

> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_cloexec(fd);

[...]


