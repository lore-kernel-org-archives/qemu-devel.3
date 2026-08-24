Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E228CC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 04:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyMi7-00052K-GH; Mon, 24 Aug 2026 00:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wyMi5-00051Y-8y; Mon, 24 Aug 2026 00:55:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wyMi3-0003X6-93; Mon, 24 Aug 2026 00:55:01 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O11dT0445204; Mon, 24 Aug 2026 04:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lsW+TZ
 1Z0tmgy0SfAhM5uBv+lVFc9/uvdwWdkJEsYjc=; b=n2CU9e5Br7SQlH4CXZeArk
 ktWYWHRg+vBy/8R5VPoMBxbbZg2rDJYvz8FyQ4MAVJFLj7InoE54oHtq9OmWsLI+
 CO4PUk9w8Y2zTIWjnLoWY8Qv3FGEmCbpxrDQrHxFdjLSZpGYi/YCqkkYWNvlaAWC
 ZOdBaU9HtMFGshCv7W58XYN9go3xVTEzMg5kMUkTLTvPvatuA5P8X3WLIJKO62Ml
 9HkUxJNtDycNVg8BSUCL489VOEpuUMAlVSDYi38hKwUeI6jjd0K0qxeFaAql66iE
 LqK96hol7wk5pmRF1F+osVw5HBxaV2l6DTFTM5xZH+glH5NdesqG1ob4Q9LxE2Dg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dwy28x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 04:54:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O4fN8e001985;
 Mon, 24 Aug 2026 04:54:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkguy7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 04:54:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67O4sq5h56099092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 04:54:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFA6D58055;
 Mon, 24 Aug 2026 04:54:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B392B58043;
 Mon, 24 Aug 2026 04:54:49 +0000 (GMT)
Received: from [9.124.213.171] (unknown [9.124.213.171])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 04:54:49 +0000 (GMT)
Message-ID: <2bb74d84-a91e-47f5-aa91-db031c4e0b44@linux.ibm.com>
Date: Mon, 24 Aug 2026 10:24:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi: validate IU buffer bounds in
 vscsi_preprocess_desc()
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, fam@euphon.net,
 pbonzini@redhat.com, amachhiw@linux.ibm.com
References: <20260819095855.115823-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260819095855.115823-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDAzOCBTYWx0ZWRfX042eHoDU9EhX
 lHsMEUE+sSWbHrzb4U/iB9zdkh6S380slJPkeme7C4l/i2NCPTSnApXbYvLdewiAlvJkh+pPXuP
 RSfoonInniMhgqn0HCol1bpvvydKguA=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8bce9f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=nkpJC4IrBe8brOV7E0kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RAft_R_fPgxeTulVC04RjupZcsOryyrE
X-Proofpoint-GUID: YoldkS77chyuwIR5VER6MoPqkW6F6Wlp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDAzOCBTYWx0ZWRfXzcLVWwGQK9l/
 4a7/7AfQVVViaTbszbwz+qaJ9PepzB0oMQnJ249Yaa7UpCaFOF1I3wCG4j/kiWH+XL/ATOpc3zh
 2T3mtEw79ADhcpxycFRnTz1Se9OsH7UAcRQLSp1YAxwr6xs7fvGpCGmxsTNqnSbyLX+Kxri+lHh
 TtwuIzL93Aew2ErI+bsWFH6tw8Szn2x2EM9hVIopW0HTEGHr40MuAS+Vn3LWyUd+xUC6OeqvbT1
 Lg44xZ48MRIVjIkbuG/5Mbj58ehkNldmj3SW9fvGl6j03lPrgAZns3x5wN8s+YLXuFezeVECm2b
 vVPoOo4b6t0tiqRf3JuzQNsSTAJV7dAys02pP9+qoOqt3f+IDRY6zLap+qq/wxKsZxWjTrehBZF
 bHZQr1D7iZpaEqHY8HsRsBlLGvLRv1eNaVi9a2auAqEJfBJmjVTj+MuhtU7OhVEH5t68u+iUNMZ
 sKNatjuedmgMQOvf5hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_01,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240038
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
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


On 8/19/26 15:28, Chinmay Rath wrote:
> cdb_offset and local_desc values are dependent on the guest. If the value
> is large enough, it can lead to an out-of-bounds read in vscsi_fetch_desc().
>
> Add an 'avail' constant in vscsi_preprocess_desc() representing the number of
> bytes available in srp_cmd.add_data[] and use it to prevent out-of-bound reads.
>
> Make all callers of vscsi_preprocess_desc() check its return value and
> handle failure accordingly.
>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4162
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reported-by: Lazymio <mio@lazym.io>
> ---
>   hw/scsi/spapr_vscsi.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index b4c8f94d22..9fef224727 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -484,6 +484,8 @@ static int data_out_desc_size(struct srp_cmd *cmd)
>   static int vscsi_preprocess_desc(vscsi_req *req)
>   {
>       struct srp_cmd *cmd = &req_iu(req)->srp.cmd;
> +    /* bytes available for descriptors behind srp_cmd.add_data */
> +    const unsigned avail = SRP_MAX_IU_LEN - offsetof(struct srp_cmd, add_data);
>   
>       req->cdb_offset = cmd->add_cdb_len & ~3;
>   
> @@ -498,16 +500,35 @@ static int vscsi_preprocess_desc(vscsi_req *req)
>       case SRP_NO_DATA_DESC:
>           break;
>       case SRP_DATA_DESC_DIRECT:
> +        if (req->cdb_offset + sizeof(struct srp_direct_buf) > avail) {
> +            fprintf(stderr,
> +                    "vscsi_preprocess_desc: direct desc out of bounds\n");
> +            return -1;
> +        }
>           req->total_desc = req->local_desc = 1;
>           break;
>       case SRP_DATA_DESC_INDIRECT: {
> -        struct srp_indirect_buf *ind_tmp = (struct srp_indirect_buf *)
> -                (cmd->add_data + req->cdb_offset);
> +        struct srp_indirect_buf *ind_tmp;
> +
> +        if (req->cdb_offset + sizeof(struct srp_indirect_buf) > avail) {
> +            fprintf(stderr,
> +                    "vscsi_preprocess_desc: indirect desc out of bounds\n");
> +            return -1;
> +        }
> +        ind_tmp = (struct srp_indirect_buf *)(cmd->add_data + req->cdb_offset);
>   
>           req->total_desc = be32_to_cpu(ind_tmp->table_desc.len) /
>                             sizeof(struct srp_direct_buf);
>           req->local_desc = req->writing ? cmd->data_out_desc_cnt :
>                             cmd->data_in_desc_cnt;
> +
> +        /* desc_list[] entries must also fit inside the IU buffer */
> +        if (req->local_desc * sizeof(struct srp_direct_buf) >
> +            avail - req->cdb_offset - sizeof(struct srp_indirect_buf)) {
> +            fprintf(stderr,
> +                    "vscsi_preprocess_desc: local_desc out of bounds\n");
> +            return -1;
> +        }
>           break;
>       }
>       default:
> @@ -725,7 +746,11 @@ static void vscsi_inquiry_no_target(VSCSIState *s, vscsi_req *req)
>       memcpy(&resp_data[8], "QEMU    ", 8);
>   
>       req->writing = 0;
> -    vscsi_preprocess_desc(req);
> +    if (vscsi_preprocess_desc(req) < 0) {
> +        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
> +        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
> +        return;
> +    }
>       rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
>       if (rc < 0) {
>           vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
> @@ -775,7 +800,12 @@ static void vscsi_report_luns(VSCSIState *s, vscsi_req *req)
>           i += 8;
>       }
>   
> -    vscsi_preprocess_desc(req);
> +    if (vscsi_preprocess_desc(req) < 0) {
> +        g_free(resp_data);
> +        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
> +        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
> +        return;
> +    }
>       rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
>       g_free(resp_data);
>       if (rc < 0) {
> @@ -823,7 +853,10 @@ static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *req)
>           req->writing = (n < 1);
>   
>           /* Preprocess RDMA descriptors */
> -        vscsi_preprocess_desc(req);
> +        if (vscsi_preprocess_desc(req) < 0) {
> +            scsi_req_cancel(req->sreq);
> +            return 1;
> +        }
>   
>           /* Get transfer direction and initiate transfer */
>           if (n > 0) {

