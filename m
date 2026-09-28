Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEF4C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB6cT-0002FS-3M; Mon, 28 Sep 2026 04:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xB6cR-0002F1-5i; Mon, 28 Sep 2026 04:21:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xB6cP-0008Sx-6w; Mon, 28 Sep 2026 04:21:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S85xIl395462; Mon, 28 Sep 2026 08:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NgONTy
 bVDaZb5tbdVHWcEZgWgRYrPmR9hBYzF25yZZ8=; b=JH+WyXGVpwukU17Lb2A648
 eHzkLEzQpXoJ/Va7qv49Yf8BZr6FB3W1sM+iN8LAL61g9wIx2hvcSFgJzX972+XU
 ydhas5FNSZEvL9Y0yS68A5BbWYq0Tk/sTO7BP/NCILR5W8/2Eu6kOhjI0C4Ge/QA
 pKKYA5uQ/NiI1Y9Q6hh8KT2eaVOfqdQPTUCV/x/OixH1M4HQgyfVUbHRLk2Wr6zj
 jSjGcEeZ+RvTvHXIWYqA4vSWCmeP+e3Adc16k66gq6J126ncVRujMCskgIrjawXI
 0QGBKDg1uciKH2zLwAMLXUg0Pm2QPFFaamv7/D4VG59iqkR04OPiTovY04Q4xftw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk04ed-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 08:21:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S82TfE3996648; Mon, 28 Sep 2026 08:21:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck4cm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 08:21:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68S8LWm715991110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 08:21:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35AEA2004D;
 Mon, 28 Sep 2026 08:21:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E304420043;
 Mon, 28 Sep 2026 08:21:31 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com (unknown
 [9.224.79.183]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 08:21:31 +0000 (GMT)
Message-ID: <5a6f7c48169f48db16b7b3b8e93e87351bbcbb1f.camel@linux.ibm.com>
Subject: Re: [PATCH] s390x/sclpconsole: implement resizing for vt220 consoles
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, filip.hejsek@gmail.com
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 qemu-s390x@nongnu.org, brueckner@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, maximilian.immanuel.brandtner@protonmail.com
Date: Mon, 28 Sep 2026 10:21:31 +0200
In-Reply-To: <831a1dbd-b48c-4430-8444-a1d3a5c1135e@linux.ibm.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
 <20260921121641.1354712-1-maxbr@linux.ibm.com>
 <831a1dbd-b48c-4430-8444-a1d3a5c1135e@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: V6S6gu2lZZnE8g3F_o6rNRhStheTy0cb
X-Proofpoint-GUID: HPAkmNjL5tbyeRc3KhmIidcRuZYRhDpz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzMiBTYWx0ZWRfX99GyotqRrHpa
 vZ9JfctEBGoRuwqZf/n/B7dpOtmPF79VOvkjpq6ywTQeWCIO6trJABHtCLuzQMpLLu/VnzWD9s7
 hbCUb+juVc4A9AfhugIfOwI1smikTQk=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6aba2391 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=rFsNrkwXQ4pkBWEt2GAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzMiBTYWx0ZWRfX1ovpx0au/D6q
 z5JTOm2IzPiHzaZUxNngy+NWk7Jo2dSrUq1YvmXhQD9mgmUb7Xm5jz3dLIz7Yvz55UsH1bIi6Bs
 LL9abIpChDvGXhDXsgMoUG8RZr0XxcAEN35j1NjUxKGgw9uDQxFVU0211Q+++ZVOSch5nY/2/CU
 TT7iP0ZczswCP9cUxBJyFngsIPMyJkCEatp+W5rVqN0u+IR0qmdnEGUI7doJ+A4+TmreEwCQ2V4
 iOKNC6wY3ktJTtxpI1YCck9nL7HogfyrEDRA+IhP9YzZ+PoVr12pW8hJhV8w6SZd/UOIzmZKeDz
 gnWqUJv2yrYAnxtnPdtmW2s+AJZce5CBbFrU9ZmmuRJQUiq4kp7DbCfkcDE3YpMvrvDz7NdX6+p
 cAWcLzFxilOEkREe8MUH0MtgTuzBvIT44ke0OQ2SnxQKz0/wPRfVRPMfPKCTYaBhfO8pZPoZKTO
 AvQRu2WnQ/pgmpDAVXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280032
Received-SPF: pass client-ip=148.163.158.5; envelope-from=maxbr@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 2026-09-24 at 22:42 -0400, Matthew Rosato wrote:
> On 9/21/26 8:16 AM, Maximilian Immanuel Brandtner wrote:
> > Adds a tty code to indicate a resize frame. The body contains two
> > big
> > endian 16-bit integers rows and columns.
> >=20
> > Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> > ---
> > Requires the following pre-req:
> > =C2=A0=C2=A0=C2=A0 [PATCH v7 00/12] virtio-console: notify about the te=
rminal size
> > =C2=A0=C2=A0=C2=A0
> > (https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c
> > 550fdcec15@gmail.com/)
> >=20
> > Testing:
> > - Tested on QEMU: commit 38879a667f with the following patches
> > applied:
> > =C2=A0=C2=A0=C2=A0 [PATCH v7 00/12] virtio-console: notify about the te=
rminal size
> > - Tested on linux-next (commit c1f49dea2b8f) with the following
> > patches
> > =C2=A0 applied:
> > =C2=A0=C2=A0=C2=A0 [PATCH 0/2] s390/sclp: Resize for sclp-vt220 console
> > ---
> > =C2=A0hw/char/sclpconsole.c | 52
> > ++++++++++++++++++++++++++++++++++++++++++-
> > =C2=A01 file changed, 51 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> > index 179d12745c..acf1fea6b5 100644
> > --- a/hw/char/sclpconsole.c
> > +++ b/hw/char/sclpconsole.c
> > @@ -42,6 +42,7 @@ struct SCLPConsole {
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t iov_data_len;=C2=A0 /* length of byte=
 stream in
> > buffer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t iov_sclp_rest; /* length of byte stre=
am not read via
> > SCLP=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0 bool notify;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* qemu_notify_event() req'd if
> > true=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 bool resize;
>=20
> Does this need to be in vmstate_sclpconsole / included in migration
> so
> we don't miss pending resize events during a migration?

No, console_init() already sets scon->resize =3D true. So after migration
a resize event is always pending.

>=20
> Also, should the resize value be explicitly set to false during
> console_reset()?

Not to false. This would eliminate the initial resize event, because
console_reset() runs after console_init(). We need an initial resize
event, because the chardev (eg chardev-stdio) might send its
initializing resize event before sclpconsole has been initialized.
That said, I think it's better for me to move the initial resize code
from console_init to console_reset.

> [...]
>=20
> > @@ -105,6 +128,28 @@ static void get_console_data(SCLPEvent *event,
> > uint8_t *buf, size_t *size,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int avail)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0 SCLPConsole *cons =3D SCLP_CONSOLE(event);
> > +=C2=A0=C2=A0=C2=A0 uint16_t be_rows, be_cols, rows, cols;
> > +
> > +=C2=A0=C2=A0=C2=A0 if (cons->resize) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (avail < 5) {
>=20
> I dislike the use of a magic number here, when it's tied directly to
> the
> combined sizes of a few structures.=C2=A0 Can you derive the size instead
> e.g.
> sizeof(*buf) + sizeof(be_rows) + sizeof(be_cols);

Sure, though sizeof(*buf) seems misleading, as we're really dealing
with a 1-byte header value which just so happens to be the same type as
the raw buffer. Looking at the code again though, I think it's best to
use a packed struct instead.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *si=
ze =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_fe_get_winsize(&co=
ns->chr, &cols, &rows);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be_rows =3D cpu_to_be16(row=
s);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be_cols =3D cpu_to_be16(col=
s);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* first byte hex 0x08 indi=
cates a new terminal size
> > follows */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *buf++ =3D 0x08;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(buf, &be_rows, sizeo=
f(be_rows));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(buf + 2, &be_cols, s=
izeof(be_cols));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *size =3D 5;
>=20
> Ditto
>=20

