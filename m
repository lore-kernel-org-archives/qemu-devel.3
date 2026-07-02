Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC7AC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 03:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf8VU-0001sD-O3; Wed, 01 Jul 2026 23:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf8VT-0001rx-DB; Wed, 01 Jul 2026 23:54:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf8VR-00039Q-Qo; Wed, 01 Jul 2026 23:54:31 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621Luff2392466; Thu, 2 Jul 2026 03:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PiwHIk
 AJFZHiV0K9Q6QZtZkzqEFBhxLaPsXQkOGcoKE=; b=SzqOiZu2IegxV5YIRg/Cr4
 gJ2lX4cKBXDJajjZOstInpAEsb6el1o75AVkp6bIEMx3f9V/7rrTe/lS6jhNZRHF
 tFG5cO3FwW/rPW6Z+GDIqA45dVFCdbkn9zt2dAvQOAA+4XWLYDk+uOJGZ8jRVRk7
 dkfnhoSXbwmGYjGeuu5o5nWdU3JnYBf0N904blgQwr9yFTdYBlBUXx9guMNTZaaS
 vAsCCgNweFFOg8i5Ke1AriX6pL6kHFl4P1kTJBB5FJoHnIqjrZwysLgz4TgEODaO
 IQf0db1HYYw0EJsjXqnYH1vot/5OB+ASnqbm3KabfOq1cvRjfoQad2MVkKHuq2uA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa7k0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:54:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6623nfGN011950;
 Thu, 2 Jul 2026 03:54:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhj7pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:54:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6623rptJ31130152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 03:53:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 923DE58053;
 Thu,  2 Jul 2026 03:54:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DF3D58059;
 Thu,  2 Jul 2026 03:54:22 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 03:54:22 +0000 (GMT)
Message-ID: <66d04ca7b82d14856a751e97db15a8d2bbacc962.camel@linux.ibm.com>
Subject: Re: [PATCH v12 10/35] hw/s390x: Define finite size for single entry
 VCEntry
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Zhuoying Cai
 <zycai@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Date: Wed, 01 Jul 2026 23:54:21 -0400
In-Reply-To: <d425523c-2892-4509-ba73-1e3988bb3e3f@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-11-zycai@linux.ibm.com>
 <d425523c-2892-4509-ba73-1e3988bb3e3f@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAzNCBTYWx0ZWRfX/filqtaSPNe2
 +9Sh8wSu0Ygm6wtl/5qQd7fgu+LsuTi9SubdNvk2c8IjKeDlm+Bd3x2JZrwEwYECvXIxwN95hkD
 Jwi8vcip8POVlTF0ZlZLbpiKKSJBDdsa2lBN219m6NZmGfOwguusrFfSuOjj0OD0G6ynwjHZakB
 MFJxnz7Vz7e2xvW3e5RHEx4I80PCRO9TA+gTTenZ598f3V55HH9b8aPKl+LE2QXPPZO7+QMgyFw
 IOa+ZLjrZeSZTIbH7q0MzKVZr9EijAq0/KdvfOJbWnv70QTz50Ueqaov8mMMA+rLlcI1ynyniy6
 WD7D36X7LHe+pBTDKW6wPINUGXGmKZN8iZuCtfLw+oSgdUuaUiilx0vYusF5rZ2aBIJFBqNacgE
 v5oDwgzCf5n7ZLjyirwTtHL1eZF5WsOEHO4TarDOz8wDxn0AULgqSUkIqDRp2eaBK/n1dZ0ADCI
 QOMcFl6Lb1rWL/xysMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAzNCBTYWx0ZWRfXztolpKgOuYn8
 e9An8bxKXMwkWShuxTn35KKe/J5nJLfQeBtOLiPbxGgR4K1Pt0WwpO5BungwstpuUQOdEce4x/p
 +DPQMEpjpyQ8NTejpgArB9xPWzGdztg=
X-Proofpoint-GUID: jmRqNfXwETvp0FFWhmg4jL9YeMt1M6Bo
X-Proofpoint-ORIG-GUID: jmRqNfXwETvp0FFWhmg4jL9YeMt1M6Bo
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a45e0f2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=qfmEaKQ5U3i9WMxNIM8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020034
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 2026-07-01 at 21:02 -0400, Matthew Rosato wrote:
> On 7/1/26 4:48 PM, Zhuoying Cai wrote:
> > Define MAX_VCENTRY_SIZE(8KB) and CERT_BUF_MAX_LEN to establish a finite
> > size for a single entry VCEntry. Add validation in update_cert_store()
> > to ensure certificate data does not exceed this limit.
> >=20
> > This finite size definition is needed for proper memory allocation and
> > will be used in a later commit to handle VCEntry structures with known
> > size constraints.
> >=20
> > Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> > ---
> >  hw/s390x/cert-store.c          | 6 ++++++
> >  include/hw/s390x/ipl/diag320.h | 3 +++
> >  2 files changed, 9 insertions(+)
> >=20
> > diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
> > index ab3abf414b..08c38d18df 100644
> > --- a/hw/s390x/cert-store.c
> > +++ b/hw/s390x/cert-store.c
> > @@ -86,6 +86,12 @@ static int update_cert_store(S390IPLCertificateStore=
 *cert_store,
> >      cert_buf_size =3D ROUND_UP(cert->der_size, 4);
> >      data_buf_size =3D keyid_buf_size + hash_buf_size + cert_buf_size;
> > =20
> > +    if (data_buf_size > CERT_BUF_MAX_LEN) {
> > +        error_report("Certificate data size %zu exceeds maximum buffer=
 size %ld",
> > +                     data_buf_size, CERT_BUF_MAX_LEN);
> > +        return -1;
> > +    }
> > +
>=20
> Took me a minute to realize why this needed to be its own patch vs
> squashed in with hw/s390x/ipl: Create certificate store, because it
> seems kind of like a fix? ...
>=20
> >      if (cert_store->largest_cert_size < data_buf_size) {
> >          cert_store->largest_cert_size =3D data_buf_size;
> >      }
> > diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag=
320.h
> > index 7fda2d44fd..f3c23a3176 100644
> > --- a/include/hw/s390x/ipl/diag320.h
> > +++ b/include/hw/s390x/ipl/diag320.h
> > @@ -92,6 +92,9 @@ struct VCEntry {
> >  };
> >  typedef struct VCEntry VCEntry;
> > =20
> > +#define MAX_VCENTRY_SIZE      (8 * 1024)
> > +#define CERT_BUF_MAX_LEN      (MAX_VCENTRY_SIZE - sizeof(VCEntryHeader=
))
> > +
>=20
> ... it's because of VCEntryHeader.  Would it be possible to instead pull
> this code, the VCEntryHeader definition and CERT_NAME_MAX_LEN back
> to 'hw/s390x/ipl: Create certificate store' so that we can detect
> this condition right from the beginning?

+1

>=20
> Otherwise, the code itself seems fine so if it can't be squashed then:
>=20
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

But I also agree it's fine.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
>=20
> >  struct VCBlockHeader {
> >      uint32_t in_len;
> >      uint32_t reserved0;

