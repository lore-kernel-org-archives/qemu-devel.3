Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CE606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bTPey81e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrx5-0003q4-BU; Thu, 05 Nov 2026 02:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1xOrwq-0003mz-Pd; Thu, 05 Nov 2026 02:31:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1xOrwn-0004qE-6k; Thu, 05 Nov 2026 02:31:47 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56iPCM1629605; Thu, 5 Nov 2026 07:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=xe5LoboSIY1F8Lq5JRykH1KhADT3/U
 v6NatXvn/sozA=; b=bTPey81eClxhCdpFHV1pYRnTqpiyYHjs/gHJ9OU4L8yTma
 Qi8+vV/exQIYdFaJx4w8C9BHz0NmYziCtdmWLP3xwB7/ggc/+cUUK6WnfkZMLwPd
 58ot0DTbnlFmG4W/8ghG7HrKLENdyKuMEqM3Ck9RMcCoJDZovckFozFTZqGwlG+l
 L+H8GNxl8WDKxwZvowOIKyA8mplhqBklvazijgl3dvU3XhxS71ek+jWDVKvq0PVH
 5scAbod0S/0TC9HyZ/V7p8s/Ip0/y5GLXsoadn7LbKPyGdDXHsCHmFzIhT21Gb2M
 kj1URlWJ+0MB0w7g78c3sW+cgr2jxc7TQaSVPwaA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdgcxb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2026 07:31:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56exB11128486; Thu, 5 Nov 2026 07:31:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmreg6fa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2026 07:31:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A57VZF048038216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2026 07:31:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF3FE20040;
 Thu,  5 Nov 2026 07:31:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8B5120043;
 Thu,  5 Nov 2026 07:31:33 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown
 [9.124.212.212])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  5 Nov 2026 07:31:33 +0000 (GMT)
Date: Thu, 5 Nov 2026 13:01:30 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, fam@euphon.net, pbonzini@redhat.com,
 amachhiw@linux.ibm.com
Subject: Re: [PATCH] hw/scsi: validate IU buffer bounds in
 vscsi_preprocess_desc()
Message-ID: <auwwnGkx1jqvuKZw@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260819095855.115823-1-rathc@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819095855.115823-1-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: nHh3oor6eZWtq_e2KzL99IVJHuCpibKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAyOCBTYWx0ZWRfXyqRk65CyF94e
 NQgsssFiioRAY7NWbmmivESu/Z6Wy2K/ket7wrLVYufxuX1Bhc70g7OhtDVQueWD437hSWNiVfG
 2XYloDZxleKHMqHP68YKOir1Hwi3FhS4Ca3E7/6zN2/dcUCJyBx2DwvUBtNofa7YA0JzBzIvdEc
 Ps9wyTOnfhX4N/7YugmQmJyhuurG8hvg8ly+w+ZSeu4xBZnNYiA7OB4sZVU8XLZqGobuSsaEn5E
 Px40w9YOCx2x8xJWPeWnrYLD+KOL91khbBX7ug10qoQhgaYg3tHUssxSBiFZTMlIzKOjcEaTEhn
 uQrKtvQOwL6CdohUADgUsyWM9bqWlpnRMBQFqIoOAgQMIID2spVa7zS5+TVLcj3G55bFIpzq/Nf
 bWJqjhvjAki+xIhCZxSRbGmn8/HYyAqvVghysqR92Hjq5M+q42wjvxxuFBeMPR6rpDirGyXObnr
 s3xlPyYJ19CBzooOQNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAyOCBTYWx0ZWRfX6ukQw9PL8Syq
 7lvUVGXuKPiZxfZP+8gIF3KbNdVHzpxezO94ed/itqIAYq0HEX7L1zmd0dY0VOjMSIWHhLfJdIF
 9hBBlgUWW8Ip+Ai47p0Q582sJymbsL4=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aec30dc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=eLGE-lYFzjDE4tTs6sYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: L0-ZahvVeuENZ9UoQTe2022YkLMHzn-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050028
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Aug 19, 2026 at 03:28:55PM +0530, Chinmay Rath wrote:
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
> ---
>  hw/scsi/spapr_vscsi.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index b4c8f94d22..9fef224727 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -484,6 +484,8 @@ static int data_out_desc_size(struct srp_cmd *cmd)
>  static int vscsi_preprocess_desc(vscsi_req *req)
>  {
>      struct srp_cmd *cmd = &req_iu(req)->srp.cmd;
> +    /* bytes available for descriptors behind srp_cmd.add_data */
> +    const unsigned avail = SRP_MAX_IU_LEN - offsetof(struct srp_cmd, add_data);
>  
>      req->cdb_offset = cmd->add_cdb_len & ~3;
>  
> @@ -498,16 +500,35 @@ static int vscsi_preprocess_desc(vscsi_req *req)
>      case SRP_NO_DATA_DESC:
>          break;
>      case SRP_DATA_DESC_DIRECT:
> +        if (req->cdb_offset + sizeof(struct srp_direct_buf) > avail) {
> +            fprintf(stderr,
> +                    "vscsi_preprocess_desc: direct desc out of bounds\n");
> +            return -1;
> +        }
>          req->total_desc = req->local_desc = 1;
>          break;
>      case SRP_DATA_DESC_INDIRECT: {
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
>          req->total_desc = be32_to_cpu(ind_tmp->table_desc.len) /
>                            sizeof(struct srp_direct_buf);
>          req->local_desc = req->writing ? cmd->data_out_desc_cnt :
>                            cmd->data_in_desc_cnt;
> +
> +        /* desc_list[] entries must also fit inside the IU buffer */
> +        if (req->local_desc * sizeof(struct srp_direct_buf) >
> +            avail - req->cdb_offset - sizeof(struct srp_indirect_buf)) {
> +            fprintf(stderr,
> +                    "vscsi_preprocess_desc: local_desc out of bounds\n");
> +            return -1;
> +        }
>          break;
>      }
>      default:
> @@ -725,7 +746,11 @@ static void vscsi_inquiry_no_target(VSCSIState *s, vscsi_req *req)
>      memcpy(&resp_data[8], "QEMU    ", 8);
>  
>      req->writing = 0;
> -    vscsi_preprocess_desc(req);
> +    if (vscsi_preprocess_desc(req) < 0) {
> +        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
> +        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
> +        return;
> +    }
>      rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
>      if (rc < 0) {
>          vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
> @@ -775,7 +800,12 @@ static void vscsi_report_luns(VSCSIState *s, vscsi_req *req)
>          i += 8;
>      }
>  
> -    vscsi_preprocess_desc(req);
> +    if (vscsi_preprocess_desc(req) < 0) {
> +        g_free(resp_data);
> +        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
> +        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
> +        return;
> +    }
>      rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
>      g_free(resp_data);
>      if (rc < 0) {
> @@ -823,7 +853,10 @@ static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *req)
>          req->writing = (n < 1);
>  
>          /* Preprocess RDMA descriptors */
> -        vscsi_preprocess_desc(req);
> +        if (vscsi_preprocess_desc(req) < 0) {
> +            scsi_req_cancel(req->sreq);
> +            return 1;
> +        }
>  
>          /* Get transfer direction and initiate transfer */
>          if (n > 0) {
> -- 
> 2.55.0
> 
> 


LGTM, did a light sanity with this
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>

